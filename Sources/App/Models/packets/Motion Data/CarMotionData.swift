//
//  CarMotionData.swift
//  
//
//  Created by Erik Hatfield on 7/24/20.
//

import Foundation
import NIO

struct CarMotionData: Codable {
    let worldPositionX: Float?
    let worldPositionY: Float?
    let worldPositionZ: Float?
    
    let worldVelocityX: Float?
    let worldVelocityY: Float?
    let worldVelocityZ: Float?
    
    let worldForwardDirX: Int?   // Int16
    let worldForwardDirY: Int?   // Int16
    let worldForwardDirZ: Int?   // Int16
    
    let worldRightDirX: Int?     // Int16
    let worldRightDirY: Int?     // Int16
    let worldRightDirZ: Int?     // Int16
    
    let gForceLateral: Float?
    let gForceLongitudinal: Float?
    let gForceVertical: Float?
    
    let yaw: Float?
    let pitch: Float?
    let roll: Float?
    
    init(data: inout ByteBuffer) throws {
        
        //let val: Float? = try data.readInteger(endianness: .little, as: UInt32.self)
        
        self.worldPositionX = data.readFloat()
        self.worldPositionY = data.readFloat()
        self.worldPositionZ = data.readFloat()
        
        self.worldVelocityX = data.readFloat()
        self.worldVelocityY = data.readFloat()
        self.worldVelocityZ = data.readFloat()
        
        self.worldForwardDirX = data.readInt(as: Int16.self)
        self.worldForwardDirY = data.readInt(as: Int16.self)
        self.worldForwardDirZ = data.readInt(as: Int16.self)
        
        self.worldRightDirX = data.readInt(as: Int16.self)
        self.worldRightDirY = data.readInt(as: Int16.self)
        self.worldRightDirZ = data.readInt(as: Int16.self)
        
        self.gForceLateral = data.readFloat()
        self.gForceLongitudinal = data.readFloat()
        self.gForceVertical = data.readFloat()
        
        self.yaw = data.readFloat()
        self.pitch = data.readFloat()
        self.roll = data.readFloat()
    }
}
