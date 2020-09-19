//
//  SessionObject.swift
//  
//
//  Created by Erik Hatfield on 8/5/20.
//

import Fluent
import Vapor

final class SessionInfo: Model, Content {
    static let schema = "sessionInfo"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "something")
    var something: String
    
    init() { }
    
    init(id: UUID? = nil, something: String) {
        self.id = id
        self.something = something
    }
}
