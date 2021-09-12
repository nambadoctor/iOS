//
//  CustomerChatView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/1/21.
//

import Foundation

import SwiftUI

var CustomerOnlineChatHelperMessages:[String] = ["Hello Dr. I am ready for call",
                               "I have a problem connecting to call",
                               "Please call me on my phone",
                               "Is my prescription ready?"]

var CustomerInPersonChatHelperMessages:[String] = ["Hello Dr. do i need to upload any reports?",
                               "What do I need to bring to hospital?",
                               "Can we reschedule?"]

struct CustomerChatRoomView: View {

    @ObservedObject var chatVM:CustomerChatViewModel
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
                    .onChange(of: chatVM.scrollToBottomListener) { _ in
                        value.scrollTo(chatVM.messageList.last?.chatMessage.messageId)
                    }
                    .onAppear() {
                        chatVM.scrollToBottomListener.toggle()
                    }
                }
            }
            .padding(.horizontal)

            Spacer()

            ScrollView (.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(self.chatVM.appointment.IsInPersonAppointment ? CustomerInPersonChatHelperMessages : CustomerOnlineChatHelperMessages, id: \.self) { message in
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
                ExpandingTextEntryView(text: self.$chatVM.currentTextEntry)
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
            chatVM.scrollToBottomListener.toggle()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
    }
    
    var backButton : some View {
        Button(action : {
            cusAutoNav.leaveChatRoom()
            self.mode.wrappedValue.dismiss()
        }){
            Image(systemName: "arrow.left")
                .padding([.top, .bottom, .trailing])
        }
    }
    
}

