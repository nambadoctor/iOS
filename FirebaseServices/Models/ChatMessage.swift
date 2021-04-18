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

struct LocalChatMessage {
    var id:String = UUID().uuidString
    var chatMessage:ChatMessage
    
    var dateHeader:String = ""
    var showDateHeader:Bool

    var isCurrentUser:Bool
    var customerName:String
    var showCustomerProfPic:Bool
}
