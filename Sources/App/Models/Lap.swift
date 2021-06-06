//
//  Lap.swift
//  
//
//  Created by Erik Hatfield on 6/5/21.
//

import Fluent
import Vapor


extension FieldKey {
    static var number: Self { "number" }
}

final class Lap: Model, Content {
    static let schema = "laps"
    
    @ID() var id: UUID?
    @Field(key: .number) var number: Int
    
    init() { }
    
    init(id: UUID? = nil, number: Int) {
        self.id = id
        self.number = number
    }
}

struct CreateLap: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Lap.schema)
            .id()
            .field(.number, .int, .required)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Todo.schema).delete()
    }
}
