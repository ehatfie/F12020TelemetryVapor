//
//  Session.swift
//  
//
//  Created by Erik Hatfield on 7/30/20.
//

import Vapor
import F12020TelemetryPackets

enum DriverStatus: Int {
    case garage = 0
    case flyingLap = 1
    case inLap = 2
    case outLap = 3
    case onTrack = 4
    case unknown = -1
    
    init(from value: Int) {
        guard let status = DriverStatus(rawValue: value) else { self = .unknown; return }
        self = status
    }
    
    var value: String {
        switch self {
        case .garage:
            return "Garage"
        case .flyingLap:
            return "Flying Lap"
        case .inLap:
            return "In Lap"
        case .outLap:
            return "Out Lap"
        case .onTrack:
            return "On Track"
        default:
            return "Unknown"
        }
    }
}

class Session {
    typealias SessionData = F12020TelemetryPackets.SessionData
    typealias SessionType = F12020TelemetryPackets.SessionType
    let sessionType: SessionType?
    var lastSessionData: SessionData?
    var lapData: LapDataSimple?
    var lastLapData: LapDataInner?
    var lastLap: LapDataInner?
    var lapDataInner: [LapDataInner] = [] // all lap data values for player car
    
    
    init(from sessionData: SessionData) {
        self.lastSessionData = nil
        self.sessionType = sessionData.sessionType
        print("Session Init")
        
       // let foo = TestClass123
    }
    
    func accept(lapData: LapDataSimple) {
        self.lapData = lapData
    }	
    
    func accept(lapData: LapDataInner) {
        let driverStatus = DriverStatus(from: lapData.driverStatus)
        let lapNum = lapData.currentLapNum
        let lapTime = lapData.currentLapTime
        let currentLapInvalid = lapData.currentLapInvalid == 1
        
        
        //print("lap: \(lapNum) time: \(lapTime) status: \(driverStatus.value) isInvalid: \(currentLapInvalid)")
        //print("distance: \(lapData.lapDistance) totalDistance: \(lapData.totalDistance)")
        self.lapDataInner.append(lapData)
         
        self.lapData = LapDataSimple(from: lapData)
        // if this packet has a new lap number the previous lapDataInner was the final one for the previous lap
        if let lastLapData = lastLapData, lapNum != lastLapData.currentLapNum {
            let lastTime = lapData.lastLapTime
            let sector1 = lastLapData.sector1Time
            let sector2 = lastLapData.sector2Time
            
            let sector3 = (Int(lastTime * 1000)) - (sector1 + sector2)
            	
            print("lap: \(lapNum) time: \(lastTime) S1: \(sector1) S2: \(sector2) S3: \(sector3)")
            self.lastLap = lastLapData
        }
        
        self.lastLapData = lapData
    }
    
    func accept(sessionData: SessionData) {
        self.lastSessionData = sessionData
    }
    
    func createSessionSummary() {
        if let lastLapData = self.lapDataInner.last {
            let lapDataSummary = LapDataSummary(from: lastLapData)
            print("Lap Data Summary \(lapDataSummary)")
            print()
        }
        
    }
}

class LapDataSummary {
    let lapCount: Int
    
    let bestLapTime: Float
    let bestLapNum: Int
    let bestLapSector1Time: Int  // sector 1 time of the best lap in the session in milliseconds
    let bestLapSector2Time: Int  // sector 2 time of the best lap in the session in milliseconds
    let bestLapSector3Time: Int  // sector 3 time of the best lap in the session in milliseconds
    
    let bestOverallSector1Time: Int
    let bestOverallSector2Time: Int
    let bestOverallSector3Time: Int
    
    let bestOverallSector1LapNum: Int // Lap number of best overall sector 1 time
    let bestOverallSector2LapNum: Int // Lap number of best overall sector 2 time
    let bestOverallSector3LapNum: Int // Lap number of best overall sector 3 time
    
    // how to prevent force unwraps?
    init(from lapData: LapDataInner) {
        
        self.lapCount = lapData.currentLapNum
        
        self.bestLapTime = lapData.bestLapTime
        self.bestLapNum = lapData.bestLapNum
        self.bestLapSector1Time = lapData.bestLapSector1Time
        self.bestLapSector2Time = lapData.bestLapSector2Time
        self.bestLapSector3Time = lapData.bestLapSector3Time
        
        self.bestOverallSector1Time = lapData.bestOverallSector1Time
        self.bestOverallSector2Time = lapData.bestOverallSector2Time
        self.bestOverallSector3Time = lapData.bestOverallSector3Time
        
        self.bestOverallSector1LapNum = lapData.bestOverallSector1LapNum
        self.bestOverallSector2LapNum = lapData.bestOverallSector2LapNum
        self.bestOverallSector3LapNum = lapData.bestOverallSector3LapNum
    }
}
