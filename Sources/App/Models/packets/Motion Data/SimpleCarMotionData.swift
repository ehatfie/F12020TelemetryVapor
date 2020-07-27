//
// SimpleCarMotionData.swift
//  
//
//  Created by Erik Hatfield on 7/25/20.
//

import Vapor

struct SimpleCarMotionData: Codable {
    let worldPositionX: Float
    let worldPositionY: Float
    let worldPositionZ: Float
    let index: Int
    
    init?(data: CarMotionData, index: Int) {
        guard let x = data.worldPositionX, let y = data.worldPositionY, let z = data.worldPositionZ
            else {
                return nil
        }
        
        self.worldPositionX = x
        self.worldPositionY = y
        self.worldPositionZ = z
        self.index = index
    }
}
