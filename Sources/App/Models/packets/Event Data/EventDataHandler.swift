//
//  EventDataHandler.swift
//  
//
//  Created by Erik Hatfield on 7/23/20.
//

import Foundation
import NIO

class EventDataHandler: PacketHandler {
    typealias PacketType = EventDataPacket
    
    func processPacket(data: inout ByteBuffer) {
        
    }
}
