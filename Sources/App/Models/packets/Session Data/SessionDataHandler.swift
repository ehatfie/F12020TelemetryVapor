//
//  SessionDataHandler.swift
//  
//
//  Created by Erik Hatfield on 7/23/20.
//

import Foundation
import NIO

class SessionDataHandler: PacketHandler {
    typealias PacketType = SessionDataPacket
    
    func processPacket(data: inout ByteBuffer) {
        
        do {
            let object = try PacketType(data: &data)
            print(object)
        } catch {
            print("SESSION DATA HANDLER CATCH")
        }
    }
}
