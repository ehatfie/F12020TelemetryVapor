////
////  CarSetupPacket.swift
////  
////
////  Created by Erik Hatfield on 7/23/20.
////
//
//import Foundation
//import NIO
//
//struct CarSetupPacket {
//    let header: PacketHeader
//    let carSetups: [CarSetupData]
//    
//    init(header: PacketHeader, data: inout ByteBuffer) throws {
//        self.header = header
//        let packet = try CarSetupData(data: &data)
//        print("CAR SETUP \(packet)")
//        self.carSetups = [packet]
//    }
//}
