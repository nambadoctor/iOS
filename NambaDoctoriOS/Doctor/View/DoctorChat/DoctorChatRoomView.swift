//
//  DoctorChatRoomView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/15/21.
//

import SwiftUI

var DoctorChatHelperMessages:[String] = ["Hello, I am waiting in the consultation room",
                               "Hi, can we have our consultation earlier?",
                               "Sorry, I will be a late for our consultation",
                               "Please upload reports if any"]

struct DoctorChatRoomView: View {
    
    @ObservedObject var chatVM:DoctorChatViewModel
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            ScrollView (.vertical) {
                ScrollViewReader {value in
                    ForEach(chatVM.messageList, id: \.id) { message in
                        if message.showDateHeader {
                            HStack {
                                VStack {Divider()}
                                Text(message.dateHeader)
                                    .font(.footnote)
                                    .foregroundColor(Color.gray)
                                    .bold()
                                VStack {Divider()}
                            }
                        }
                        
                        MessageView(currentMessage: message)
                            .id(message.chatMessage.messageId)
                    }
                    .onChange(of: chatVM.takeToBottomListener) { _ in
                        value.scrollTo(chatVM.messageList.last?.chatMessage.messageId)
                    }
                    .onAppear() {
                        chatVM.takeToBottomListener.toggle()
                    }
                }
            }
            .padding(.horizontal)

            Spacer()

            ScrollView (.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(DoctorChatHelperMessages, id: \.self) { message in
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
                ExpandingTextView(text: self.$chatVM.currentTextEntry)
                Button {
                    chatVM.writeMessage()
                } label: {
                    Image("paperplane.fill")
                        .foregroundColor(.blue)
                        .padding(5)
                }
            }.frame(minHeight: CGFloat(30))
            .padding(.horizontal)
            .padding(.bottom, 2)
        }
        .onAppear() {
            LocalNotifStorer().clearNewChatsCountForAppointment(appointmentId: self.chatVM.appointment.appointmentID)
        }
        .onTapGesture {
            EndEditingHelper.endEditing()
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardDidShowNotification)) { _ in
            chatVM.takeToBottomListener.toggle()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
    }
    
    var backButton : some View {
        Button(action : {
            docAutoNav.leaveChatRoom()
            self.mode.wrappedValue.dismiss()
        }){
            Image(systemName: "arrow.left")
                .padding([.top, .bottom, .trailing])
        }
    }
    
}

