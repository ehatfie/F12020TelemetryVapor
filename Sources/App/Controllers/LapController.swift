//
//  LapController.swift
//  
//
//  Created by Erik Hatfield on 6/5/21.
//

import Fluent
import Vapor


struct LapController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let laps = routes.grouped("laps")
        laps.get(use: index)
        laps.post(use: create)
        laps.group(":lapID") { lap in
            lap.delete(use: delete)
        }
    }

    func index(req: Request) throws -> EventLoopFuture<[Lap]> {
        return Lap.query(on: req.db).all()
    }

    func create(req: Request) throws -> EventLoopFuture<Lap> {
        let lap = try req.content.decode(Lap.self)
        return lap.save(on: req.db).map { lap }
    }

    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return Lap.find(req.parameters.get("lapID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .transform(to: .ok)
    }
}
