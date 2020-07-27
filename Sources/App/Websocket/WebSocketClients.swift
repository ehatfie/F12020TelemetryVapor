//
//  WebsocketClients.swift
//  
//
//  Created by Erik Hatfield on 7/24/20.
//

import Vapor

open class WebsocketClients {
    var eventLoop: EventLoop
    var storage: [UUID: WebsocketClient]
    
    var active: [WebsocketClient] {
        self.storage.values.filter({ !$0.socket.isClosed })
    }
    
    init(eventLoop: EventLoop, clients: [UUID: WebsocketClient] = [:]) {
        self.eventLoop = eventLoop
        self.storage = clients
    }
    
    func add(_ client: WebsocketClient) {
        print("CLIENTS ADD")
        self.storage[client.id] = client
    }
    
    func remove(_ client: WebsocketClient) {
        self.storage[client.id] = nil
    }
    
    func find(_ uuid: UUID) -> WebsocketClient? {
        return self.storage[uuid]
    }
    
    deinit {
        let futures = self.storage.values.map { $0.socket.close() }
        
        // flatten so that we dont leave before all websocket.close() complete
        try! self.eventLoop.flatten(futures).wait()
    }
}
