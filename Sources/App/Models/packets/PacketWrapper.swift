//
//  PacketWrapper.swift
//  
//
//  Created by Erik Hatfield on 7/27/20.
//

import Foundation

public class PacketWrapper<T: Codable>: Codable {
    let packetType: String
    let data: T
    
    init(type: String, packetData: T) {
        self.packetType = type
        self.data = packetData
    }
}
