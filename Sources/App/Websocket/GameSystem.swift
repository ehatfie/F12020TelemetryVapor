//
//  GameSystem.swift
//  
//
//  Created by Erik Hatfield on 7/24/20.
//

import Vapor

public class GameSystem {
    var clients: WebsocketClients
    var timer: Timer? = nil
    var counter: Int = 0
    
    init(eventLoop: EventLoop) {
        self.clients = WebsocketClients(eventLoop: eventLoop)
        
    }
    
    @objc func doSomething() {
        print("do something")
        counter += 1
        self.notify()
    }
    
    func sendData(carData: SimpleCarMotionData) {
        let players = self.clients.active.compactMap({$0 as? PlayerClient})
        print("PLAYERS COUNT \(players.count)")
        guard !players.isEmpty else { return }
        
        let message = "{\"cool\": \(counter)}"
        
        let data = try! JSONEncoder().encode(carData)
        players.forEach { player in
            print("SENDING \(message) TO \(player)")
            player.socket.send([UInt8](data))
        }
    }
    
    func connect(_ ws: WebSocket) {
        print("CONNECT")
        
        //self.timer = Timer.scheduledTimer(timeInterval: TimeInterval(1), target: self, selector: #selector(doSomething), userInfo: nil, repeats: true)
        
        ws.onBinary { [unowned self] ws, buffer in
            print("ON BINARY")
            if let message = buffer.decodWebsocketMessage(Connect.self) {
//                let player = PlayerClient(id: message.client, socket: ws, status: .init(id: nil))
//                self.clients.add(player)
//                self.notify()
            }
        }
        let player = PlayerClient(id: UUID(), socket: ws, status: .init(id: nil))
        self.clients.add(player)
        //self.notify()
        //let something = 
    }
    
    func notify() {
        let players = self.clients.active.compactMap({$0 as? PlayerClient})
        print("PLAYERS COUNT \(players.count)")
        guard !players.isEmpty else { return }
        
        let message = "{\"cool\": \(counter)}"
        let data = try! JSONEncoder().encode(message)
        players.forEach { player in
            print("SENDING \(message) TO \(player)")
            player.socket.send([UInt8](data))
        }
    }
}
