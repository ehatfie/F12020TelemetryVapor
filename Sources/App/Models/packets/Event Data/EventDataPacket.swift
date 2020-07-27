//
//  File.swift
//  
//
//  Created by Erik Hatfield on 7/23/20.
//

import Foundation
import NIO

enum EventStringCode: String {
    case SSTA = "SSTA" // session started
    case SEND = "SEND" // session ended
    case FTLP = "FTLP" // fastest lap
    case RTMT = "RTMT" // retirement
    case DRSE = "DRSE" // drs enabled
    case DRSD = "DRSD" // drs disabled
    case TMPT = "TMPT" // team mate in pits
    case CHQF = "CHQF" // chequered flag
    case RCWN = "RCWN" // race winner
    case ERRO = "ERROR" // error
    
    init(value: String?) {
        guard let value = value else { self = .ERRO; return }
        self = EventStringCode(rawValue: value) ?? EventStringCode.ERRO
    }
}

struct EventDataPacket {
    let header: PacketHeader
    let eventStringCode: EventStringCode
    let vehicleIdx: Int?         // uint8
    let lapTime: Float?
    
    init(header: PacketHeader, data: inout ByteBuffer) throws {
        self.header = header
        let eventString = data.readString(length: 4)
        self.eventStringCode = EventStringCode(value: eventString)
        
        self.vehicleIdx = data.readInt(as: UInt8.self)
        self.lapTime = data.readFloat()
    }
}
