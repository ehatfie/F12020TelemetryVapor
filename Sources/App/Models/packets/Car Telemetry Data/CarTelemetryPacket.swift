//
// CarTelemetryPacket.swift
//  
//
//  Created by Erik Hatfield on 7/23/20.
//

import Foundation
import NIO

struct CarTelemetryDataPacket {
    let header: PacketHeader
    let carTelemetryData: [CarTelemetryData]
    let buttonStatus: Int? // uint32 fit flags specifying which buttons are being pressed
    let mfdPanelIndex: Int? // uint8 Index of MFD Panel open - 255 = MCD closed
                            // singleplayer, race - 0 =  Car setup, 1 = Pits 2 = Damage, 3 = Enigne, 4 = Temperature
    let mfdPanelIndexSecondaryPlayer: Int? //UInt8, same as above
    let suggestedGear: Int? //Int8 //suggested gear for the player (1-8) and 0 if no gear selected
    
    init(header: PacketHeader, data: inout ByteBuffer) throws {
        self.header = header
        let packet = try CarTelemetryData(data: &data)
        self.carTelemetryData = [packet]
        
        self.buttonStatus = data.readInt(as: UInt32.self)
        self.mfdPanelIndex = data.readInt(as: UInt8.self)
        self.mfdPanelIndexSecondaryPlayer = data.readInt(as: UInt8.self)
        self.suggestedGear = data.readInt(as: Int8.self)
    }
}
