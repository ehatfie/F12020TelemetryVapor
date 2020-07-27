//
//  LapDataInner.swift
//  
//
//  Created by Erik Hatfield on 7/23/20.
//

import Foundation
import Vapor
import NIO

struct LapDataInner {
    let lastLapTime: Float?
    let currentLapTime: Float?
    
    let sector1Time: UInt16?          // sector 1 time in milliseconds
    let sector2Time: UInt16?          // sector 2 time in milliseconds
    
    let bestLapTime: Float?          // best lap time of the session
    let bestLapNum: UInt8?           // Lap number the best lap time was set on
    let bestLapSector1Time: UInt16? // sector 1 time of the best lap in the session in milliseconds
    let bestLapSector2Time: UInt16? // sector 2 time of the best lap in the session in milliseconds
    let bestLapSector3Time: UInt16? // sector 3 time of the best lap in the session in milliseconds
    
    let bestOverallSector1Time: UInt16? // Best overall sector 1 time of the session
    let bestOverallSector1LapNum: UInt8? // Lap number of best overall sector 1 time
    let bestOverallSector2Time: UInt16? // Best overall sector 2 time of the session
    let bestOverallSector2LapNum: UInt8? // lap number of best overall sector 2 time
    let bestOverallSector3Time: UInt16? // best overall sector 3 time of the session
    let bestOverallSector3LapNum: UInt8? // lap numbe rof best overall sector 3 time
    
    let lapDistance: Float?          // distance car is around current lap in meters
    let totalDistance: Float?        // total distance travelled in session in meters
    
    let safetyCarDelta: Float?       // delta in seconds for safety car
    let carPosition: UInt8?            // uint8 car race position
    let currentLapNum: UInt8?          // uint8
    let pitStatus: UInt8?              // uint8 0 = none, 1 = pitting, 2 = in pits
    let sector: UInt8?                 // uint8 0 = sector1, 1 = sector2, etc
    let currentLapInvalid: UInt8?      // uint8 0 =  valid, 1 = invalid
    let penalties: UInt8?              // uint8 accumulated time penalties in seconds
    let gridPosition: UInt8?           // uint8 grid position vehicle started in
    let driverStatus: UInt8?           // uint8 0 = inGarage, 1 = flyingLap, 2 = inLap, 3 = outLap, 4 = onTrack
    let resultStatus: UInt8?           // uint8 0 = invalid, 1 = inactive, 2 = active, 3 = finished, 4 = disqualified, 5 = notClassified, 6 = retired
    
    init(data: inout ByteBuffer) throws {
        self.lastLapTime = data.readFloat()
        self.currentLapTime = data.readFloat()
        
        self.sector1Time = data.readInteger(endianness: .little, as: UInt16.self)
        self.sector2Time = data.readInteger(endianness: .little, as: UInt16.self)
        
        self.bestLapTime = data.readFloat()
        self.bestLapNum = data.readInteger(endianness: .little, as: UInt8.self)
        self.bestLapSector1Time = data.readInteger(endianness: .little, as: UInt16.self)
        self.bestLapSector2Time = data.readInteger(endianness: .little, as: UInt16.self)
        self.bestLapSector3Time = data.readInteger(endianness: .little, as: UInt16.self)
        
        self.bestOverallSector1Time = data.readInteger(endianness: .little, as: UInt16.self)
        self.bestOverallSector1LapNum = data.readInteger(endianness: .little, as: UInt8.self)
        self.bestOverallSector2Time = data.readInteger(endianness: .little, as: UInt16.self)
        self.bestOverallSector2LapNum = data.readInteger(endianness: .little, as: UInt8.self)
        self.bestOverallSector3Time = data.readInteger(endianness: .little, as: UInt16.self)
        self.bestOverallSector3LapNum = data.readInteger(endianness: .little, as: UInt8.self)
        
        self.lapDistance = data.readFloat()
        self.totalDistance = data.readFloat()
        
        self.safetyCarDelta = data.readFloat()
        self.carPosition = data.readInteger(endianness: .little, as: UInt8.self)
        self.currentLapNum = data.readInteger(endianness: .little, as: UInt8.self)
        self.pitStatus = data.readInteger(endianness: .little, as: UInt8.self)
        self.sector = data.readInteger(endianness: .little, as: UInt8.self)
        self.currentLapInvalid = data.readInteger(endianness: .little, as: UInt8.self)
        self.penalties = data.readInteger(endianness: .little, as: UInt8.self)
        self.gridPosition = data.readInteger(endianness: .little, as: UInt8.self)
        self.driverStatus = data.readInteger(endianness: .little, as: UInt8.self)
        self.resultStatus = data.readInteger(endianness: .little, as: UInt8.self)
    }
    
}



