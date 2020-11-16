//
//  Session.swift
//  
//
//  Created by Erik Hatfield on 7/30/20.
//

import Vapor
import F12020TelemetryPackets

class Session {
    typealias SessionData = F12020TelemetryPackets.SessionData
    typealias SessionType = F12020TelemetryPackets.SessionType
    let sessionType: SessionType?
    var lastSessionData: SessionData?
    var lapData: LapDataSimple?
    var lapDataInner: [LapDataInner] = [] // all lap data values for player car
    
    
    init(from sessionData: SessionData) {
        self.lastSessionData = nil
        self.sessionType = sessionData.sessionType
        print("Session Init")
    }
    
    func accept(lapData: LapDataSimple) {
        self.lapData = lapData
    }
    
    func accept(lapData: LapDataInner) {
        self.lapDataInner.append(lapData)
         
        self.lapData = LapDataSimple(from: lapData)
        //print("new lap data count: \(self.lapDataInner.count)")
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
        
        self.lapCount = Int(lapData.currentLapNum)
        
        self.bestLapTime = lapData.bestLapTime
        self.bestLapNum = Int(lapData.bestLapNum)
        self.bestLapSector1Time = Int(lapData.bestLapSector1Time)
        self.bestLapSector2Time = Int(lapData.bestLapSector2Time)
        self.bestLapSector3Time = Int(lapData.bestLapSector3Time)
        
        self.bestOverallSector1Time = Int(lapData.bestOverallSector1Time)
        self.bestOverallSector2Time = Int(lapData.bestOverallSector2Time)
        self.bestOverallSector3Time = Int(lapData.bestOverallSector3Time)
        
        self.bestOverallSector1LapNum = Int(lapData.bestOverallSector1LapNum)
        self.bestOverallSector2LapNum = Int(lapData.bestOverallSector2LapNum)
        self.bestOverallSector3LapNum = Int(lapData.bestOverallSector3LapNum)
    }
}
