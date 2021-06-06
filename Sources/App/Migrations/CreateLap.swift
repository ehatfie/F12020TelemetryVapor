//
//  File.swift
//  
//
//  Created by Erik Hatfield on 6/5/21.
//

import Fluent

//struct CreateLap: Migration {
//    func prepare(on database: Database) -> EventLoopFuture<Void> {
//        return database.schema(Todo.schema)
//            .id()
//            .field(.title, .string, .required)
//            .field(.status, .string, .required)
//            .field(.labels, .int, .required)
//            .field(.due, .datetime)
//            .create()
//    }
//    
//    
//    func revert(on database: Database) -> EventLoopFuture<Void> {
//        return database.schema(Todo.schema).delete()
//    }
//}
