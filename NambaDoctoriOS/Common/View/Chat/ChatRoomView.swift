//
//  ChatRoomView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/14/21.
//

import SwiftUI

struct ContentMessageView: View {
    var contentMessage: String
    var timestamp:Int64
    var isCurrentUser: Bool
    
    var body: some View {
        VStack (alignment: isCurrentUser ? .trailing : .leading, spacing: 0) {
            Text(contentMessage)
                .padding(10)
                .foregroundColor(isCurrentUser ? Color.white : Color.black)
                .background(isCurrentUser ? Color.blue : Color(UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)))
                .cornerRadius(10)
            
            Text(Helpers.getSimpleTimeForAppointment(timeStamp1: timestamp))
                .font(.footnote)
                .foregroundColor(.gray)
                .padding(.bottom, 2)
        }
    }
}

struct MessageView : View {
    var currentMessage:LocalChatMessage
    
    var body: some View {
        HStack(alignment: .center, spacing: 15) {
            if !currentMessage.isCurrentUser {
                if currentMessage.showCustomerProfPic {
                    LetterOnColoredCircle(word: currentMessage.customerName, color: .green, width: 40, height: 40, textSize: 18)
                } else {
                    VStack{}.frame(width: 40, height: 40)
                }
            } else {
                Spacer()
            }

            ContentMessageView(contentMessage: currentMessage.chatMessage.message, timestamp: currentMessage.chatMessage.timeStamp,
                               isCurrentUser: currentMessage.isCurrentUser)
            if !currentMessage.isCurrentUser {
                Spacer()
            }

        }
    }
}
