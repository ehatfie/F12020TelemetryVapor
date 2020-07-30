//
//  SesionDataPacket.swift
//  
//
//  Created by Erik Hatfield on 7/23/20.
//

import Vapor

struct SessionDataPacket {
    let header: PacketHeader?
    let weather: Int?                // uint8 0  = clear, 1  = lightCloud, 2  = overcast, 3  = lightRain, 4  = heavyRain, 5  = storm
    let trackTemperature: Int? //int8      // track temperature in degrees
    let airTemperature: Int? //int8        // air temperature in celcius
    
    let totalLaps: Int? //uint8            // total number of laps in the race
    let trackLength: Int? // uint16         // track lenght in meters
    let sessionType: Int? // uint8          // 0  = unknown, 1  = Practice 1, 2  = Practice 2, 3  = Practice 3, 4  = short practice 5  = Q1, 6  = Q2, 7  = Q3, 8  = short Qualifying, 9  = One Shot Qualifying, 10  = Race, 11  = Race2, 12  = Time Trial
    let trackId: Int? // int8               //  -1 for uknown 0 =21 for tracks in season order
    let m_formula: Int? // uint8            // Formula type, 0 = F1 Modern, 1 = F1 Classic, 2 = F2
    
    let sessionTimeLeft: Int? // uint16     // time left in session in seconds
    let sessionDuration: Int? // uint16     // session duration in seconds
    
    let pitSpeedLimiter: Int? // uint8        // pit speed limit in km/h
    
    let gamePaused: Int? // Uint8           // whether game is paused
    let isSpectating: Int? // uint8         // whether player is spectating
    let spectatorCarIndex: Int? // uint8    // index of car being spectated
    let sliProNativeSupport: Int? // uint8  // 0 = inactive, 1 = active
    
    let numMarshalZones: Int? // uint8      // number of marshal zones max 21
    let marshalZones: [MarshalZone] // list of marshal zones
    let safetyCarStatus: Int? // uint8      // 0 = no safety car, 1 = full safety car, 2 = virtual safety car
    let networkGame: Int? // uint8          // 0 = offline, 1 = online
    let numWeatherForecastSamples: Int? // uint8
    let weatherForecastSamples: [WeatherForecastSample]
    
    init(header: PacketHeader? = nil, data: inout ByteBuffer) throws {
        self.header = header
        
        self.weather = data.readInt(as: UInt8.self)
        self.trackTemperature = data.readInt(as: Int8.self)
        self.airTemperature = data.readInt(as: Int8.self)
        
        self.totalLaps = data.readInt(as: UInt8.self)
        self.trackLength = data.readInt(as: UInt16.self)
        self.sessionType = data.readInt(as: UInt8.self)
        self.trackId = data.readInt(as: Int8.self)
        self.m_formula = data.readInt(as: UInt8.self)
        
        self.sessionTimeLeft = data.readInt(as: UInt16.self)
        self.sessionDuration = data.readInt(as: UInt16.self)
        
        self.pitSpeedLimiter = data.readInt(as: UInt8.self)
        
        self.gamePaused = data.readInt(as: UInt8.self)
        self.isSpectating = data.readInt(as: UInt8.self)
        self.spectatorCarIndex = data.readInt(as: UInt8.self)
        self.sliProNativeSupport = data.readInt(as: UInt8.self)
        
        self.numMarshalZones = data.readInt(as: UInt8.self)
        
        var raceMarshalZones = [MarshalZone]()
        for _ in 0..<(numMarshalZones ?? 1) {
            raceMarshalZones.append(try MarshalZone(data: &data))
        }
        
        self.marshalZones = raceMarshalZones
        self.safetyCarStatus = data.readInt(as: UInt8.self)
        self.networkGame = data.readInt(as: UInt8.self)
        self.numWeatherForecastSamples = data.readInt(as: UInt8.self)
        
        var forecastSamples = [WeatherForecastSample]()
        
        for _ in 0..<(self.numWeatherForecastSamples ?? 0) {
            if let forecast = try? WeatherForecastSample(data: &data) {
                forecastSamples.append(forecast)
            }
        }
        
        self.weatherForecastSamples = forecastSamples
    }
}

struct SessionData: Codable {
    let sessionType: SessionType
    let weather: WeatherType
    let trackName: String
    let totalLaps: Int
    let sessionTimeLeft: Int
    let sessionDuration: Int
    
    enum CodingKeys: CodingKey {
        case sessionType, weather, totalLaps, trackName, sessionTimeLeft, sessionDuration
    }
    
    init(from data: SessionDataPacket) {
        self.sessionType = SessionType(from: data.sessionType)
        self.weather = WeatherType(from: data.weather)
        self.totalLaps = data.totalLaps ?? -1
        self.trackName = TrackIDs[data.trackId ?? -1] ?? "Unrecognized Track"
        self.sessionTimeLeft = data.sessionTimeLeft ?? -1
        self.sessionDuration = data.sessionDuration ?? -1
    }
    
    // not using
    init(from decoder: Decoder) throws {
        self.sessionType = .unknown
        self.weather = .unknown
        self.trackName = "Unknown"
        self.totalLaps = -1
        self.sessionTimeLeft = -1
        self.sessionDuration = -1
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(sessionType.value, forKey: .sessionType)
        try container.encode(weather.value, forKey: .weather)
        try container.encode(trackName, forKey: .trackName)
        try container.encode(totalLaps, forKey: .totalLaps)
        try container.encode(sessionTimeLeft, forKey: .sessionTimeLeft)
        try container.encode(sessionDuration, forKey: .sessionDuration)
    }
}
