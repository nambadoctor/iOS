//
//  DoctorChatRoomView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/15/21.
//

import SwiftUI

var helperMessages:[String] = ["Hi, can we have our consultation earlier?",
                               "Sorry, I will be a late for our consultation",
                               "Hello, I am waiting in the consultation room",
                               "Please upload reports if any"]

struct DoctorChatRoomView: View {
    
    @ObservedObject var chatVM:DoctorChatViewModel
    
    init(appointment:ServiceProviderAppointment) {
        chatVM = DoctorChatViewModel(appointment: appointment)
    }

    var body: some View {
        VStack {
            ScrollView (.vertical) {
                ScrollViewReader {value in
                    ForEach(chatVM.messageList, id: \.messageId) { message in
                        MessageView(currentMessage: message, isCurrentUser: chatVM.checkIfMessageIsFromCurrentUser(message: message), customerName: chatVM.appointment.customerName)
                            .id(message.messageId)
                    }.onChange(of: chatVM.takeToBottomListener) { _ in
                        value.scrollTo(chatVM.messageList.last?.messageId)
                    }
                }
            }
            .padding(.horizontal)

            Spacer()
            
            ScrollView (.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(helperMessages, id: \.self) { message in
                        ZStack {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(Color.white)
                                .shadow(color: .gray,radius: 2)

                            Text(message)
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                                .padding(5)
                                .multilineTextAlignment(.center)
                                .fixedSize(horizontal: false, vertical: true)
                                .lineLimit(2)
                        }
                        .frame(width: 200, height: 50)
                        .padding([.top, .leading])
                        .padding(.bottom, 5)
                        .onTapGesture () {
                            chatVM.preSetMessageSelected(message: message)
                        }
                    }
                }
            }
            
            HStack {
                ExpandingTextView(text: $chatVM.currentTextEntry)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(minHeight: CGFloat(30))
                Button(action: chatVM.writeMessage) {
                    Image("paperplane.fill")
                        .foregroundColor(.blue)
                }
            }.frame(minHeight: CGFloat(30))
            .padding(.horizontal)
            .padding(.bottom, 2)
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardDidShowNotification)) { _ in
            chatVM.takeToBottomListener = UUID().uuidString
        }
    }
}

