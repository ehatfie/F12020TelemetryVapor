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
        
        let wrapper = PacketWrapper<SimpleCarMotionData>(type: "SimpleCarMotionData", packetData: carData)
        let data = try! JSONEncoder().encode(wrapper)
        
        players.forEach { player in
            player.socket.send([UInt8](data))
        }
    }
    // combine sends to be some generic something
    func sendData(lapData: LapDataInner) {
        let players = self.clients.active.compactMap({$0 as? PlayerClient})
        
        guard !players.isEmpty else { return }
        let lapDataSimple = LapDataSimple(from: lapData)
        let wrapper = PacketWrapper<LapDataSimple>(type:"LapDataSimple", packetData: lapDataSimple)
        let data = try! JSONEncoder().encode(wrapper)
        players.forEach { player in
            player.socket.send([UInt8](data))
        }
    }
    
    func connect(_ ws: WebSocket) {
        print("CONNECT")
        
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
