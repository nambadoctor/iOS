//
//  CreateChannel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 03/02/21.
//

import Foundation
import GRPC
import NIO

class CreateChannel {
    
    var channel:ClientConnection?
    
    init() {
        createChannel()
    }
    
    public func getChannel () -> ClientConnection {
        if channel == nil {
            return self.createChannel()
        } else {
            return channel!
        }
    }
    
    private func createChannel () -> ClientConnection {
        let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)

        // Make sure the group is shutdown when we're done with it.
        defer {
          try! group.syncShutdownGracefully()
        }

        // Configure the channel, we're not using TLS so the connection is `insecure`.
        channel = ClientConnection.insecure(group: group)
          .connect(host: "http://52.182.227.174/", port: 80)
        
        // Close the connection when we're done with it.
        do {
          try! channel?.close().wait()
        }
        
        return channel!
    }
}
