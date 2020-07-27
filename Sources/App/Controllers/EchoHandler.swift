//
//  EchoHandler.swift
//  
//
//  Created by Erik Hatfield on 7/23/20.
//

import Foundation
import NIO

class UdpEchoHandler: ChannelInboundHandler {
    let websocketClient: GameSystem
    typealias InboundIn = AddressedEnvelope<ByteBuffer>
    
    init(client: GameSystem) {
        self.websocketClient = client
    }
    
    public func channelRead(context: ChannelHandlerContext, data: NIOAny) {
        let addressedEnvelope = self.unwrapInboundIn(data)
        
        var byteBuffer = addressedEnvelope.data
        do {
            let header = try PacketHeader(data: &byteBuffer)
            let packet = try PacketInfo(format: header.packetFormat, version: header.packetVersion, type: header.packetId)
            if packet.packetType == .Motion {
                let motionPacket = try MotionDataPacket(header: header, data: &byteBuffer)
                let carData = motionPacket.carMotionData.first!
                print("Motion X: \(carData.worldPositionX!) Y: \(carData.worldPositionY!) Z: \(carData.worldPositionZ!)")
                
                print("PREWRITE")
                if let simpleCarData = SimpleCarMotionData(data: carData, index: Int(header.frameIdentifier!)) {
                    websocketClient.sendData(carData: simpleCarData)
                }
                
                gotOne(carData)
                //context.write(something)
               // EventLoopFuture.
            }
        } catch let error {
            print("ERROR \(error)")
        } 
    }
}

class OtherEchoHandler: ChannelInboundHandler {
    typealias InboundIn = AddressedEnvelope<ByteBuffer>
    
    public func channelRead(context: ChannelHandlerContext, data: NIOAny) {
       // let addressedEnvelope = self.unwrapInboundIn(data)
        print("OTHER ECHO HANDLER")
        if let thisValue = data as? CarMotionData {
            print("GOTTEM")
        }
    }
}

public func startUDP(system: GameSystem) {
    print("START UDP")
    
    let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
    let channelSocketOptions = (SocketOptionLevel(SOL_SOCKET), SO_REUSEADDR)
    
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
    let bindToAddress = "192.168.1.119"
    
    do {
        let channel = try datagramBootstrap.bind(host: bindToAddress, port: port).wait()

        print("Channel accepting connections on \(channel.localAddress!))")
        
        try channel.closeFuture.wait()
    } catch {
        print("ERROR CATCH")
    }

    print("Channel closed")
    
}

func gotOne(_ value: CarMotionData) {
    print("NICE \(value)")
}
