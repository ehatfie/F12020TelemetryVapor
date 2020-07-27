//
//  ParticipantData.swift
//  
//
//  Created by Erik Hatfield on 7/23/20.
//

import Foundation
import NIO

struct ParticipantData {
    let aiConrolled: Bool       // uint8
    let driverId: Int?           // uint8
    let teamId: Int?             // uint8
    let raceNumber: Int?         // uint8
    let nationality: String?     // convert from int
    let name: String?            // ctypes.c_char * 48 null terminated if too long
    let yourTelemetry: Int?      // 0 = restricted, 1 = public
    
    init(data: inout ByteBuffer) throws {
        self.aiConrolled = data.readInt(as: UInt8.self) == 1
        self.driverId = data.readInt(as: UInt8.self)
        self.teamId = data.readInt(as: UInt8.self)
        self.raceNumber = data.readInt(as: UInt8.self)
        
        let nationalityVal = data.readInt(as: UInt8.self)
        
        self.nationality = NationalityIDs[nationalityVal ?? 404] ?? "NO PARTICIPANT NATIONALITY"
        
        self.name = data.readString(length: 48) ?? "NO PARTICIPANT NAME"
        self.yourTelemetry = data.readInt(as: UInt8.self)
    }
}
