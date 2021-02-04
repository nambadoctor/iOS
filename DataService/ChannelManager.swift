//
//  CreateChannel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 03/02/21.
//

import Foundation
import GRPC
import NIO

class ChannelManager {

    static let sharedChannelManager = ChannelManager()
    var channel:ClientConnection?

    //Private init for singleton class. No other caller can initialise this class anymore.
    private init(){ createChannel() }
    
    public func getChannel() -> ClientConnection {
        if channel == nil {
            return createChannel()
        } else {
            return channel!
        }
    }

    private func createChannel () -> ClientConnection {
        let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)

        // Configure the channel, we're not using TLS so the connection is `insecure`.
        channel = ClientConnection.insecure(group: group)
            .connect(host: "52.182.227.174", port: 80)

        return channel!
    }
}
