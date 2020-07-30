//
//  SessionType.swift
//  
//
//  Created by Erik Hatfield on 7/28/20.
//

import Foundation

enum SessionType: Int {
    case unknown = 0
    case fp1 = 1
    case fp2 = 2
    case fp3 = 3
    case shortPractice = 4
    case q1 = 5
    case q2 = 6
    case q3 = 7
    case shortQualifying = 8
    case oneShotQualifying = 9
    case race = 10
    case race2 = 11 //??
    case timeTrial = 12
    
    init(from value: Int?) {
        guard let val = value, let e = SessionType(rawValue: val) else { self = .unknown; return }
        self = e
    }
    
    var value: String {
        switch self {
        case .fp1:
            return "Free Practice 1"
        case .fp2:
            return "Free Practice 2"
        case .fp3:
            return "Free Practice 3"
        case .shortPractice:
            return "Short Practice"
        case .q1:
            return "Q1"
        case .q2:
            return "Q2"
        case .q3:
            return "Q3"
        case .shortQualifying:
            return "Short Qualifying"
        case .oneShotQualifying:
            return "One Shot Qualifying"
        case .race :
            return "Race"
        case .race2:
            return "Race2"
        case .timeTrial:
            return "TimeTrial"
        default:
            return "Unknown Session Type"
        }
    }
}
