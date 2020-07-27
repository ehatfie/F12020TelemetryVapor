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

let TeamIDs: [Int: String] = [
    0: "Mercedes",
    1: "Ferrari",
    2: "Red Bull Racing",
    3: "Williams",
    4: "Racing Point",
    5: "Renault",
    6: "Toro Rosso",
    7:"Haas",
    8: "McLaren",
    9: "Alfa Romeo",
    10: "McLaren 1988",
    11: "McLaren 1991",
    12: "Williams 1992",
    13: "Ferrari 1995",
    14: "Williams 1996",
    15: "McLaren 1998",
    16: "Ferrari 2002",
    17: "Ferrari 2004",
    18: "Renault 2006",
    19: "Ferrari 2007",
    21: "Red Bull 2010",
    22: "Ferrari 1976",
    23: "ART Grand Prix",
    24: "Campos Vexatec Racing",
    25: "Carlin",
    26: "Charouz Racing System",
    27: "DAMS",
    28: "Russian Time",
    29: "MP Motorsport",
    30: "Pertamina",
    31: "McLaren 1990",
    32: "Trident",
    33: "BWT Arden",
    34: "McLaren 1976",
    35: "Lotus 1972",
    36: "Ferrari 1979",
    37: "McLaren 1982",
    38: "Williams 2003",
    39: "Brawn 2009",
    40: "Lotus 1978",
    63: "Ferrari 1990",
    64: "McLaren 2010",
    65: "Ferrari 2010"
]

let DriverIDs: [Int: String] = [
    0: "Carlos Sainz",
    1: "Daniil Kvyat",
    2: "Daniel Ricciardo",
    6: "Kimi Räikkönen",
    7: "Lewis Hamilton",
    9: "Max Verstappen",
    10: "Nico Hulkenberg",
    11: "Kevin Magnussen",
    12: "Romain Grosjean",
    13: "Sebastian Vettel",
    14: "Sergio Perez",
    15: "Valtteri Bottas",
    19: "Lance Stroll",
    20: "Arron Barnes",
    21: "Martin Giles",
    22: "Alex Murray",
    23: "Lucas Roth",
    24: "Igor Correia",
    25: "Sophie Levasseur",
    26: "Jonas Schiffer",
    27: "Alain Forest",
    28: "Jay Letourneau",
    29: "Esto Saari",
    30: "Yasar Atiyeh",
    31: "Callisto Calabresi",
    32: "Naota Izum",
    33: "Howard Clarke",
    34: "Wilhelm Kaufmann",
    35: "Marie Laursen",
    36: "Flavio Nieves",
    37: "Peter Belousov",
    38: "Klimek Michalski",
    39: "Santiago Moreno",
    40: "Benjamin Coppens",
    41: "Noah Visser",
    42: "Gert Waldmuller",
    43: "Julian Quesada",
    44: "Daniel Jones",
    45: "Artem Markelov",
    46: "Tadasuke Makino",
    47: "Sean Gelael",
    48: "Nyck De Vries",
    49: "Jack Aitken",
    50: "George Russell",
    51: "Maximilian Günther",
    52: "Nirei Fukuzumi",
    53: "Luca Ghiotto",
    54: "Lando Norris",
    55: "Sérgio Sette Câmara",
    56: "Louis Delétraz",
    57: "Antonio Fuoco",
    58: "Charles Leclerc",
    59: "Pierre Gasly",
    62: "Alexander Albon",
    63: "Nicholas Latifi",
    64: "Dorian Boccolacci",
    65: "Niko Kari",
    66: "Roberto Merhi",
    67: "Arjun Maini",
    68: "Alessio Lorandi",
    69: "Ruben Meijer",
    70: "Rashid Nair",
    71: "Jack Tremblay",
    74: "Antonio Giovinazzi",
    75: "Robert Kubica"
]

let TrackIDs: [Int: String] = [
    0: "Melbourne",
    1: "Paul Ricard",
    2: "Shanghai",
    3: "Sakhir (Bahrain)",
    4: "Catalunya",
    5: "Monaco",
    6: "Montreal",
    7: "Silverstone",
    8: "Hockenheim",
    9: "Hungaroring",
    10: "Spa",
    11: "Monza",
    12: "Singapore",
    13: "Suzuka",
    14: "Abu Dhabi",
    15: "Texas",
    16: "Brazil",
    17: "Austria",
    18: "Sochi",
    19: "Mexico",
    20: "Baku (Azerbaijan)",
    21: "Sakhir Short",
    22: "Silverstone Short",
    23: "Texas Short",
    24: "Suzuka Short"
]

let NationalityIDs: [Int: String] = [
    1: "American",
    2: "Argentinian",
    3: "Australian",
    4: "Austrian",
    5: "Azerbaijani",
    6: "Bahraini",
    7: "Belgian",
    8: "Bolivian",
    9: "Brazilian",
    10: "British",
    11: "Bulgarian",
    12: "Cameroonian",
    13: "Canadian",
    14: "Chilean",
    15: "Chinese",
    16: "Colombian",
    17: "Costa Rican",
    18: "Croatian",
    19: "Cypriot",
    20: "Czech",
    21: "Danish",
    22: "Dutch",
    23: "Ecuadorian",
    24: "English",
    25: "Emirian",
    26: "Estonian",
    27: "Finnish",
    28: "French",
    29: "German",
    30: "Ghanaian",
    31: "Greek",
    32: "Guatemalan",
    33: "Honduran",
    34: "Hong Konger",
    35: "Hungarian",
    36: "Icelander",
    37: "Indian",
    38: "Indonesian",
    39: "Irish",
    40: "Israeli",
    41: "Italian",
    42: "Jamaican",
    43: "Japanese",
    44: "Jordanian",
    45: "Kuwaiti",
    46: "Latvian",
    47: "Lebanese",
    48: "Lithuanian",
    49: "Luxembourger",
    50: "Malaysian",
    51: "Maltese",
    52: "Mexican",
    53: "Monegasque",
    54: "New Zealander",
    55: "Nicaraguan",
    56: "North Korean",
    57: "Northern Irish",
    58: "Norwegian",
    59: "Omani",
    60: "Pakistani",
    61: "Panamanian",
    62: "Paraguayan",
    63: "Peruvian",
    64: "Polish",
    65: "Portuguese",
    66: "Qatari",
    67: "Romanian",
    68: "Russian",
    69: "Salvadoran",
    70: "Saudi",
    71: "Scottish",
    72: "Serbian",
    73: "Singaporean",
    74: "Slovakian",
    75: "Slovenian",
    76: "South Korean",
    77: "South African",
    78: "Spanish",
    79: "Swedish",
    80: "Swiss",
    81: "Thai",
    82: "Turkish",
    83: "Uruguayan",
    84: "Ukrainian",
    85: "Venezuelan",
    86: "Welsh"
]

let SurfaceTypes: [Int: String] = [
    0: "Tarmac",
    1: "Rumble strip",
    2: "Concrete",
    3: "Rock",
    4: "Gravel",
    5: "Mud",
    6: "Sand",
    7: "Grass",
    8: "Water",
    9: "Cobblestone",
    10: "Metal",
    11: "Ridged"
]

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
