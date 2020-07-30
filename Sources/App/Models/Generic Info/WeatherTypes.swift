//
//  WeatherTypes.swift
//  
//
//  Created by Erik Hatfield on 7/28/20.
//

import Foundation

enum WeatherType: Int {
    case clear = 0
    case lightCloud = 1
    case overcast = 2
    case lightRain = 3
    case heavyRain = 4
    case storm = 5
    case unknown
    
    init(from value: Int?) {
        guard let val = value, let e = WeatherType(rawValue: val) else { self = .unknown; return }
        self = e
    }
    
    var value: String {
        switch self {
        case .clear:
            return "Clear"
        case .lightCloud:
            return "Light Clouds"
        case .overcast:
            return "Overcast"
        case .lightRain:
            return "Light Rain"
        case .heavyRain:
            return "Heavy Rain"
        case .storm:
            return "Storm"
        default:
            return "Unknown"
        }
    }
}

extension WeatherType: Codable {
    
}
