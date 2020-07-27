//
//  ParticipantDataPacket.swift
//  
//
//  Created by Erik Hatfield on 7/23/20.
//

import Foundation

struct ParticipantDataPacket {
    let header: PacketHeader
    let numActiveCars: Int
    let participants: [ParticipantData]
    
    init(header: PacketHeader) {
        self.header = header
        self.numActiveCars = 99
        self.participants = []
    }
}
