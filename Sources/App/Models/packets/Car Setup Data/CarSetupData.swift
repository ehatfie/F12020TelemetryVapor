////
////  CarSetupData.swift
////  
////
////  Created by Erik Hatfield on 7/23/20.
////
//
//import Foundation
//import NIO
//
//struct CarSetupData {
//    let frontWing: Int? // uint8.self
//    let rearWing: Int? // uint8.self
//    
//    let onThrottle: Int? // uint8.self, Diff adjustment on throttle %
//    let offThrottle: Int? // uint8.self, Diff adjustment off throttle %
//    
//    let frontCamber: Float? // front camber angle
//    let rearCamber: Float? // rear camber angle
//    
//    let frontToe: Float?
//    let rearToe: Float?
//    
//    let frontSuspension: Int? // uint8.self
//    let rearRuspension: Int? // uint8.self
//    
//    let frontAntiRollBar: Int? // uint8.self
//    let rearAntiRollBar: Int? // uint8.self
//    
//    let frontSuspensionHeight: Int? // uint8.self
//    let rearSuspensionHeight: Int? // uint8.self
//    
//    let brakePressure: Int? // uint8.self, percentage
//    let brakeBias: Int? // uint8.self, percentage
//    
//    let frontLeftTirePressure: Float? // PSI
//    let frontRightTirePressure: Float? // PSI
//    
//    let rearLeftTirePressure: Float? // PSI
//    let rearRightTirePressure: Float? // PSI
//    
//    let ballast: Int? // uint8.self
//    let fuelLoad: Float?
//    
//    init(data: inout ByteBuffer) throws {
//        self.frontWing = data.readInt(as: UInt8.self)
//        self.rearWing = data.readInt(as: UInt8.self)
//        
//        self.onThrottle = data.readInt(as: UInt8.self)
//        self.offThrottle = data.readInt(as: UInt8.self)
//        
//        self.frontCamber = data.readFloat()
//        self.rearCamber = data.readFloat()
//        
//        self.frontToe = data.readFloat()
//        self.rearToe = data.readFloat()
//        
//        self.frontSuspension = data.readInt(as: UInt8.self)
//        self.rearRuspension = data.readInt(as: UInt8.self)
//        
//        self.frontAntiRollBar = data.readInt(as: UInt8.self)
//        self.rearAntiRollBar = data.readInt(as: UInt8.self)
//        
//        self.frontSuspensionHeight = data.readInt(as: UInt8.self)
//        self.rearSuspensionHeight = data.readInt(as: UInt8.self)
//        
//        self.brakePressure = data.readInt(as: UInt8.self)
//        self.brakeBias = data.readInt(as: UInt8.self)
//        
//        self.frontLeftTirePressure = data.readFloat()
//        self.frontRightTirePressure = data.readFloat()
//        
//        self.rearLeftTirePressure = data.readFloat()
//        self.rearRightTirePressure = data.readFloat()
//        
//        self.ballast = data.readInt(as: UInt8.self)
//        self.fuelLoad = data.readFloat()
//    }
//}
//
//  CarSetupData.swift
//
//
//  Created by Erik Hatfield on 7/23/20.
//

import Foundation
import NIO
import F12020TelemetryPackets

public struct CarSetupData2: Equatable {
    public let frontWing: Int  // uint8.self
    public let rearWing: Int  // uint8.self
    
    public let onThrottle: Int  // uint8.self, Diff adjustment on throttle %
    public let offThrottle: Int  // uint8.self, Diff adjustment off throttle %
    
    public let frontCamber: Float  // front camber angle
    public let rearCamber: Float  // rear camber angle
    
    public let frontToe: Float
    public let rearToe: Float
    
    public let frontSuspension: Int  // uint8.self
    public let rearSuspension: Int  // uint8.self
    
    public let frontAntiRollBar: Int  // uint8.self
    public let rearAntiRollBar: Int  // uint8.self
    
    public let frontSuspensionHeight: Int  // uint8.self
    public let rearSuspensionHeight: Int  // uint8.self
    
    public let brakePressure: Int  // uint8.self, percentage
    public let brakeBias: Int  // uint8.self, percentage
    
    public let frontLeftTirePressure: Float  // PSI
    public let frontRightTirePressure: Float  // PSI
    
    public let rearLeftTirePressure: Float  // PSI
    public let rearRightTirePressure: Float  // PSI
    
    public let ballast: Int  // uint8.self
    public let fuelLoad: Float
    
    public init?(data: inout ByteBuffer) {
        guard let frontWing = data.readInt(as: UInt8.self),
              let rearWing = data.readInt(as: UInt8.self),
              let onThrottle = data.readInt(as: UInt8.self),
              let offThrottle = data.readInt(as: UInt8.self),
              let frontCamber = data.readFloat(),
              let rearCamber = data.readFloat(),
              let frontToe = data.readFloat(),
              let rearToe = data.readFloat(),
              let frontSuspension = data.readInt(as: UInt8.self),
              let rearSuspension = data.readInt(as: UInt8.self),
              let frontAntiRollbar = data.readInt(as: UInt8.self),
              let rearAntiRollbar = data.readInt(as: UInt8.self),
              let frontSuspensionHeight = data.readInt(as: UInt8.self),
              let rearSuspensionHeight = data.readInt(as: UInt8.self),
              let brakePressure = data.readInt(as: UInt8.self),
              let brakeBias = data.readInt(as: UInt8.self),
              let frontLeftTirePressure = data.readFloat(),
              let frontRightTirePressure = data.readFloat(),
              let rearLeftTirePressure = data.readFloat(),
              let rearRightTirePressure = data.readFloat(),
              let ballast = data.readInt(as: UInt8.self),
              let fuelLoad = data.readFloat()
        else {
            return nil
        }
              
        self.frontWing = frontWing
        self.rearWing = rearWing
        
        self.onThrottle = onThrottle
        self.offThrottle = offThrottle
        
        self.frontCamber = frontCamber
        self.rearCamber = rearCamber
        
        self.frontToe = frontToe
        self.rearToe = rearToe
        
        self.frontSuspension = frontSuspension
        self.rearSuspension = rearSuspension
        
        self.frontAntiRollBar = frontAntiRollbar
        self.rearAntiRollBar = rearAntiRollbar
        
        self.frontSuspensionHeight = frontSuspensionHeight
        self.rearSuspensionHeight = rearSuspensionHeight
        
        self.brakePressure = brakePressure
        self.brakeBias = brakeBias
        
        self.frontLeftTirePressure = frontLeftTirePressure
        self.frontRightTirePressure = frontRightTirePressure
        
        self.rearLeftTirePressure = rearLeftTirePressure
        self.rearRightTirePressure = rearRightTirePressure
        
        self.ballast = ballast
        self.fuelLoad = fuelLoad
    }
    
    init(from data: CarSetupData) {
        
        self.frontWing = data.frontWing
        self.rearWing =  data.rearWing
        
        self.onThrottle =  data.onThrottle
        self.offThrottle = data.offThrottle
        
        self.frontCamber =  data.frontCamber
        self.rearCamber =  data.rearCamber
        
        self.frontToe =  data.frontToe
        self.rearToe =  data.rearToe
        
        self.frontSuspension =  data.frontSuspension
        
        self.rearSuspension =  data.rearSuspension
        
        self.frontAntiRollBar =  data.frontAntiRollBar
        self.rearAntiRollBar =  data.rearAntiRollBar
        
        self.frontSuspensionHeight =  data.frontSuspensionHeight
        self.rearSuspensionHeight =  data.rearSuspensionHeight
        
        self.brakePressure =  data.brakePressure
        self.brakeBias =  data.brakeBias
        
        self.frontLeftTirePressure =  data.frontLeftTirePressure
        self.frontRightTirePressure =  data.frontRightTirePressure
        
        self.rearLeftTirePressure =  data.rearLeftTirePressure
        self.rearRightTirePressure =  data.rearRightTirePressure
        
        self.ballast =  data.ballast
        self.fuelLoad =  data.fuelLoad
        
    }
}
