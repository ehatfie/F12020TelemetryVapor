//
//  EchoHandler.swift
//  
//
//  Created by Erik Hatfield on 7/23/20.
//

import Foundation
import NIO
import F12020TelemetryPackets

class UdpEchoHandler: ChannelInboundHandler {
    // rename eventually
    let websocketClient: GameSystem
    let sessionManager: SessionManager
    
    typealias InboundIn = AddressedEnvelope<ByteBuffer>
    
    init(client: GameSystem) {
        self.websocketClient = client
        self.sessionManager = SessionManager()
    }
    
    public func channelRead(context: ChannelHandlerContext, data: NIOAny) {
        let addressedEnvelope = self.unwrapInboundIn(data)
        
        var byteBuffer = addressedEnvelope.data
        
        guard let header = PacketHeader(data: &byteBuffer) else { return }
        let packet = PacketInfo(format: header.packetFormat, version: header.packetVersion, type: header.packetId)

        if packet.packetType == .Motion {
            self.handleMotionData(header: header, data: &byteBuffer)
        } else if packet.packetType == .LapData {
            self.handleLapData(header: header, data: &byteBuffer)
        } else if packet.packetType == .SessionData {
            self.handleSessionData(header: header, data: &byteBuffer)
        } else if packet.packetType == .EventData {
            self.handleEventData(header: header, data: &byteBuffer)
        }
    }
    
    func handleMotionData(header: PacketHeader, data byteBuffer: inout ByteBuffer) {
        guard let motionPacket = MotionDataPacket(header: header, data: &byteBuffer) else { return }
        let carData = motionPacket.carMotionData.first!
        
//        if let simpleCarData = SimpleCarMotionData(data: carData, index: Int(header.frameIdentifier!)) {
//            //websocketClient.sendData(carData: simpleCarData)
//        }
    }
    
    func handleLapData(header: PacketHeader, data byteBuffer: inout ByteBuffer) {
        guard let lapDataPacket = LapDataPacket(header: header, data: &byteBuffer) else { return }
        self.sessionManager.newLapDataPacket(lapData: lapDataPacket)
    }
    
    func handleSessionData(header: PacketHeader, data byteBuffer: inout ByteBuffer) {
        guard let sessionDataPacket = SessionDataPacket(header: header, data: &byteBuffer) else {
            return }
        
        let sessionData = SessionData(from: sessionDataPacket)
        self.sessionManager.newSessionData(data: sessionData)
    }
    
    func handleEventData(header: PacketHeader, data byteBuffer: inout ByteBuffer) {
        guard let eventDataPacket = EventDataPacket(header: header, data: &byteBuffer) else { return }
        let event = eventDataPacket.eventStringCode.value
        print("event: \(event)")
        if eventDataPacket.eventStringCode == .SessionStart {
            // do something?
        } else if eventDataPacket.eventStringCode == .SessionEnd {
            self.sessionManager.endSession()
        }
//        if eventDataPacket.eventStringCode == .SessionStart {
//            self.websocketClient.newSession()
//        }
//        websocketClient.sendData(sessionData: sessionData)
    }
}

public func startUDP(system: GameSystem) {
    print("START UDP")
    let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
    
    let datagramBootstrap = DatagramBootstrap(group: group)
        .channelOption(ChannelOptions.socketOption(.so_reuseaddr),value: 1)
        .channelInitializer({ channel in
            return channel.pipeline.addHandler(UdpEchoHandler(client: system))
        })
    
    defer {
        print("DEFER")
        try! group.syncShutdownGracefully()
    }
    
    let defaultPort = 20777
    
    let arguments = CommandLine.arguments
    
    let port = arguments.dropFirst() // drop first argument
        .compactMap {Int($0)} // remove nil values and convert to Int
        .first ?? defaultPort // get port or use default if no valid port was provided
    
    // TODO: get this address from commandline
    let bindToAddress = "192.168.1.206"
    
    do {
        let channel = try datagramBootstrap.bind(host: bindToAddress, port: port).wait()

        print("Channel accepting connections on \(channel.localAddress!))")
        
        try channel.closeFuture.wait()
    } catch let error {
        print("ERROR CATCH \(error)")
    }

    print("Channel closed")
    
}

func gotOne(_ value: CarMotionData) {
    print("NICE \(value)")
}
