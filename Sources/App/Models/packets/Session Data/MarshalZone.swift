////
////  MarshalZone.swift
////  
////
////  Created by Erik Hatfield on 7/23/20.
////
//
//import Foundation
import NIO
//
//struct MarshalZone {
//    let zoneStart: Float? // fraction (0..1) of way through the lap the zone starts
//    let zoneFlag: Int? //Int8 // -1 invalid/unknown, 0 = none, 1 = green, 2 = blue, 3 = yellow, 4 = red
//    
//    init(data: inout ByteBuffer) throws {
//        
//        self.zoneStart = data.readFloat()
//        self.zoneFlag = data.readInt(as: Int8.self)
//    }
//}
extension ByteBuffer {
    mutating func readInt2<T: FixedWidthInteger>(as: T.Type = T.self) -> Int? {
        guard let data = self.readInteger(endianness: .little, as: T.self) else { return nil }
        //Int(exactly: data)
        //Int(bitPattern: T)
        return Int(truncatingIfNeeded: data)
    }
}

protocol DataPacket {
    init?(data: inout ByteBuffer)
}

public struct MarshalZone2: DataPacket {
    public let zoneStart: Float // fraction (0..1) of way through the lap the zone starts
    public let zoneFlag: Int //Int8 // -1 invalid/unknown, 0 = none, 1 = green, 2 = blue, 3 = yellow, 4 = red
    
    public init?(data: inout ByteBuffer) {
        guard let zoneStart = data.readFloat(),
              let zoneFlag = data.readInt(as: Int8.self)
        else {
            return nil
        }
        self.zoneStart = zoneStart
        self.zoneFlag = zoneFlag
    }
    
    public init() {
        zoneStart = 0
        zoneFlag = -1
    }
}
