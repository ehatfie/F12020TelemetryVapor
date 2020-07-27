//
//  LapDataPacket.swift
//  
//
//  Created by Erik Hatfield on 7/23/20.
//

import Foundation
import NIO

struct LapDataPacket {
    /**
     The lap data packet gives details of all the cars in the session.
     Frequency: Rate as specified in menus
     Size: 843 bytes
     Version: 1
     */
    let header: PacketHeader?
    let lapData: [LapDataInner] // lap data for all cars on track
    
    init(header: PacketHeader? = nil, data: inout ByteBuffer) throws {
        self.header = header
        let temp = try LapDataInner(data: &data)
        //print("LapDataInner \(temp)")
        //let temp1 = try LapDataInner(data: &data)
        self.lapData = [temp]
    }
}
