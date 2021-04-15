//
//  ChatMessage.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/14/21.
//

import Foundation

struct ChatMessage : Codable {
    var messageId:String
    var message:String
    var senderId:String
    var timeStamp:Int64
    var appointmentId:String
    var serviceProviderId:String
    var customerId:String
}
