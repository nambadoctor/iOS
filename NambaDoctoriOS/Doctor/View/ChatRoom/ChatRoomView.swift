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
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 15) {
            if !isCurrentUser {
                Image("person.crop.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40, alignment: .center)
                    .cornerRadius(20)
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

struct ChatRoomView: View {
    
    @ObservedObject var chatVM:ChatViewModel
    
    init(appointment:ServiceProviderAppointment) {
        chatVM = ChatViewModel(appointment: appointment)
    }

    var body: some View {
        VStack {
            
            ForEach(chatVM.messageList, id: \.messageId) { message in
                MessageView(currentMessage: message, isCurrentUser: chatVM.checkIfMessageIsFromCurrentUser(message: message))
            }

            Spacer()
            HStack {
                TextField("Message...", text: $chatVM.currentTextEntry)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(minHeight: CGFloat(30))
                Button(action: chatVM.writeMessage) {
                    Text("Send")
                }
            }.frame(minHeight: CGFloat(50)).padding()
            
        }.padding()
    }
}
