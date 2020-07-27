//
//  WebsocketMessage.swift
//  
//
//  Created by Erik Hatfield on 7/24/20.
//

import Vapor

struct WebsocketMessage<T: Codable>: Codable {
    let client: UUID
    let data: T
}

extension ByteBuffer {
    func decodWebsocketMessage<T: Codable>(_ type: T.Type) -> WebsocketMessage<T>? {
        try? JSONDecoder().decode(WebsocketMessage<T>.self, from: self)
    }
}
