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
