//
//  CreateChannel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 03/02/21.
//

import Foundation
import GRPC
import NIO
import NIOHPACK
import NIOHTTP1
import NIOHTTP2

class ChannelManager {
    //production ip:- 52.182.227.174
    //testing ip:- 52.233.76.64
    static let sharedChannelManager = ChannelManager(host: "52.233.76.64", port: 80)
    private var channel:ClientConnection?
    private var callOptions:CallOptions?
    
    private var host:String
    private var port:Int

    //Private init for singleton class. No other caller can initialise this class anymore.
    private init(host:String, port:Int){
        self.host = host
        self.port = port
        _ = createChannel()
    }

    public func getChannel() -> ClientConnection {
        if channel == nil {
            return createChannel()
        } else {
            return channel!
        }
    }

    public func getCallOptions() -> CallOptions {
        if callOptions == nil {
            return getAuthHeader()
        } else {
            return callOptions!
        }
    }

    private func createChannel () -> ClientConnection {
        let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
        print("creating channel")
        // Configure the channel, we're not using TLS so the connection is `insecure`.
        channel = ClientConnection
            .insecure(group: group)
            .connect(host: self.host, port: self.port)
        print("created channel")
        return channel!
    }

    private func getAuthHeader() -> CallOptions {
        let headers: HPACKHeaders = ["authorization": "Bearer \(AuthTokenId)"]
        return CallOptions(customMetadata: headers)
    }

    public func getTestAuthHeader(userId:String, phoneNumber:String) -> CallOptions {
        print("No bearer NDTest_Ios \(userId) \(phoneNumber)")
        let headers: HPACKHeaders = ["authorization": "Bearer NDTest_Ios \(userId) \(phoneNumber)"]
        return CallOptions(customMetadata: headers)
    }
}

extension ChannelManager {
    static let testChannelManager = ChannelManager(host: "52.233.76.64", port: 80)
}
