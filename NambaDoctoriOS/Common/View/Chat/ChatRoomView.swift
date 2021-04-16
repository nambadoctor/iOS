//
//  ChatRoomView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/14/21.
//

import SwiftUI

struct ContentMessageView: View {
    var contentMessage: String
    var isCurrentUser: Bool
    
    var body: some View {
        Text(contentMessage)
            .padding(10)
            .foregroundColor(isCurrentUser ? Color.white : Color.black)
            .background(isCurrentUser ? Color.blue : Color(UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)))
            .cornerRadius(10)
    }
}

struct MessageView : View {
    var currentMessage:ChatMessage
    var isCurrentUser:Bool = false
    var customerName:String
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 15) {
            if !isCurrentUser {
                LetterOnColoredCircle(word: customerName, color: .green, width: 40, height: 40, textSize: 18)
            } else {
                Spacer()
            }

            ContentMessageView(contentMessage: currentMessage.message,
                               isCurrentUser: isCurrentUser)
            if !isCurrentUser {
                Spacer()
            }

        }
    }
}
