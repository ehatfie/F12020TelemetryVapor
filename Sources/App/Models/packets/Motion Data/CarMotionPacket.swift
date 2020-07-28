//
//  CarMotionPacket.swift
//  
//
//  Created by Erik Hatfield on 7/24/20.
//

import Vapor

class MotionDataPacketHandler: PacketHandler {
    typealias PacketType = MotionDataPacket
    
    func processPacket(data: inout ByteBuffer) {
        
    }
}

struct MotionDataPacket {
    let header: PacketHeader
    var carMotionData: [CarMotionData]
    
    /*
     TODO:
     suspensionPosition RL, RR, FL, FR
     suspensionVelocity RL, RR, FL, FR
     suspensionAcceleration RL, RR, FL, FR
     wheelSpeed RL, RR, FL, FR
     wheelSlip RL, RR, FL, FR
     */
    let suspensionPosition: [Float?]
    let suspensionVelocity: [Float?]
    let suspensionAcceleration: [Float?]
    let wheelSpeed: [Float?]
    let wheelSlip: [Float?]
    // velocities in local space
    let localVelocityX: Float?
    let localVelocityY: Float?
    let localVelocityZ: Float?
    
    let angularVelocityX: Float?
    let angularVelocityY: Float?
    let angularVelocityZ: Float?
    
    let angularAccelerationX: Float?
    let angularAccelerationY: Float?
    let angularAccelerationZ: Float?
    
    // current front wheel angle in raidians
    var frontWheelsAngle: Float?
    
    init(header: PacketHeader, data: inout ByteBuffer) throws {
        self.header = header
        
        let motionData = try CarMotionData(data: &data)
        carMotionData = [motionData]
        
        self.suspensionPosition = data.getTireInfo(data: &data)
        self.suspensionVelocity = data.getTireInfo(data: &data)
        self.suspensionAcceleration = data.getTireInfo(data: &data)
        self.wheelSpeed = data.getTireInfo(data: &data)
        self.wheelSlip = data.getTireInfo(data: &data)
        
        self.localVelocityX = data.readFloat()
        self.localVelocityY = data.readFloat()
        self.localVelocityZ = data.readFloat()
        
        self.angularVelocityX = data.readFloat()
        self.angularVelocityY = data.readFloat()
        self.angularVelocityZ = data.readFloat()
        
        self.angularAccelerationX = data.readFloat()
        self.angularAccelerationY = data.readFloat()
        self.angularAccelerationZ = data.readFloat()
        
        self.frontWheelsAngle = data.readFloat()
    }
}

extension ByteBuffer {
    // rename
    func getTireInfo(data: inout ByteBuffer) -> [Float?] {
        var values = [Float?]()
        for _ in 0..<4 {
            values.append(data.readFloat())
        }
        return values
    }
}
