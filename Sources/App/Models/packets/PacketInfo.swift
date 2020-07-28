//
//  PacketInfo.swift
//  
//
//  Created by Erik Hatfield on 7/23/20.
//

import Foundation
import NIO

// todo: move this
protocol PacketHandler {
    func processPacket(data: inout ByteBuffer)
}

struct E: Error {
    
}

struct PacketInfo: Hashable {
    let packetFormat: Int
    let packetVersion: Int
    let packetType: PacketType
    
    init (format: Int?, version: Int?, type: Int?) throws {
        guard
            let format = format,
            let version = version,
            let type = type
        else {
            throw E()
        }
        
        self.packetFormat = format
        self.packetVersion = version
        self.packetType = PacketType(rawValue: type) ?? .none
    }
    
    init (format: UInt16?, version: UInt8?, type: UInt8?) throws {
        guard
            let format = format,
            let version = version,
            let type = type
        else {
            throw E()
        }
        
        self.packetFormat = Int(format)
        self.packetVersion = Int(version)
        self.packetType = PacketType(rawValue: Int(type)) ?? .none
    }
    
    // default initializer
    init (format: Int, version: Int, type: Int) {
        self.packetFormat = format
        self.packetVersion = version
        self.packetType = PacketType(rawValue: version) ?? .none
    }
}

let HeaderFieldsToPacketType: [PacketInfo: PacketHandler] = [
//    PacketInfo(format: 2020, version: 1, type: 0): MotionDataPacketHandler(),
    PacketInfo(format: 2020, version: 1, type: 1): SessionDataHandler(),
    PacketInfo(format: 2020, version: 1, type: 2): LapDataHandler(),
//    PacketInfo(format: 2020, version: 1, type: 3): EventDataHandler(),
//    PacketInfo(format: 2020, version: 1, type: 4): ParticipantDataHandler(),
//    PacketInfo(format: 2020, version: 1, type: 5): CarSetupDataHandler(),
//    PacketInfo(format: 2020, version: 1, type: 6): CarTelemetryDataHandler(),
//    PacketInfo(format: 2020, version: 1, type: 7): CarStatusDataHandler()
]

enum PacketType: Int {
    case Motion = 0
    case SessionData = 1
    case LapData = 2
    case EventData = 3
    case Participants = 4
    case CarSetups = 5
    case CarTelemetry = 6
    case CarStatus = 7
    case FinalClassification = 8
    case LobbyInfo = 9
    case none = -1
    
    var handler: PacketHandler.Type? {
        switch self {
        case .SessionData:
            return SessionDataHandler.self
        case .LapData:
            return LapDataHandler.self
        default:
            return nil
        }
    }
}
