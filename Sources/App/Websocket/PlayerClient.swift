//
//  PlayerClient.swift
//  
//
//  Created by Erik Hatfield on 7/24/20.
//


import Vapor

final class PlayerClient: WebsocketClient {
    struct Status: Codable {
        var id: UUID!
    }
    
    public init(id: UUID, socket: WebSocket, status: Status) {
        print("PLAYER CLIENT INIT")
        super.init(id: id, socket: socket)
    }
}
