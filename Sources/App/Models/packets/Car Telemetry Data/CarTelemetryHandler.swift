//
//  CarTelemetryHandler.swift
//  
//
//  Created by Erik Hatfield on 7/23/20.
//

import Foundation
import NIO

class CarTelemetryDataHandler: PacketHandler {
    typealias PacketType = CarTelemetryDataPacket
    
    func processPacket(data: inout ByteBuffer) {
        
    }
}
