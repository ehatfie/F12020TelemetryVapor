//
//  WeatherForecastSample.swift
//  
//
//  Created by Erik Hatfield on 7/23/20.
//

import Foundation
import NIO

struct WeatherForecastSample {
    let sessionType: UInt8? // 0 = unknown, 1 = P1, 2 = P2, 3 = P3, 4 = Short P, 5 = Q1, 6 = Q2, 7 = Q3, 8 = Short Q, 9 = OSQ, 10 = R, 11 = R2
    let timeOffset: UInt8? // Time in minutes the forecast is for
    let weather: UInt8? // Weather - 0 = clear, 1 = light cloud, 2 = overcast // can be enum
    let trackTemperature: UInt8? // Track temp in degrees Celsius
    let airTemperature: UInt8? // air temp in degrees Celsius
    
    init(data: inout ByteBuffer) throws {
        self.sessionType = data.readInteger(endianness: .little, as: UInt8.self)
        self.timeOffset = data.readInteger(endianness: .little, as: UInt8.self)
        self.weather = data.readInteger(endianness: .little, as: UInt8.self)
        self.trackTemperature = data.readInteger(endianness: .little, as: UInt8.self)
        self.airTemperature = data.readInteger(endianness: .little, as: UInt8.self)
    }
}
