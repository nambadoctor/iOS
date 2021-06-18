//
//  CustomerChatViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/30/21.
//

import Foundation

class CustomerChatViewModel: ObservableObject {
    var appointment:CustomerAppointment
    
    private var dbRef:ChatDatabaseReference
    private var realtimeDBRef:RealtimeDBListener
    private var customerNotifHelpers:CustomerNotificationHelper

    @Published var messageList:[LocalChatMessage] = [LocalChatMessage]()
    @Published var currentTextEntry:String = ""

    @Published var scrollToBottomListener:Bool = false

    init(appointment:CustomerAppointment) {
        self.appointment = appointment
        self.dbRef = ChatDatabaseReference(serviceProviderId: appointment.serviceProviderID, customerId: appointment.customerID)
        self.realtimeDBRef = RealtimeDBListener(dbQuery: dbRef.getChatToReadRefForServiceProvider(serviceProviderId: appointment.serviceProviderID, customerId: appointment.customerID))
        self.customerNotifHelpers = CustomerNotificationHelper(appointment: appointment)

        startMessageAddedListener()
        cusAutoNav.enterChatRoom(appointmentId: appointment.appointmentID)
    }

    private func startMessageAddedListener () {
        var recentDate:String = ""
        var showCustomerProfilePic:Bool = true
        func makeChatObj (chatObj:ChatMessage) -> LocalChatMessage {
            
            let isCurrentUser = checkIfMessageIsFromCurrentUser(message: chatObj)
            
            if isCurrentUser {showCustomerProfilePic = true}
            
            var localChatObj = LocalChatMessage(chatMessage: chatObj, showDateHeader: false, isCurrentUser: isCurrentUser, customerName: self.appointment.customerName, showCustomerProfPic: showCustomerProfilePic)
            
            let displayDate = Helpers.getDisplayForDateSelector(timeStamp: chatObj.timeStamp)
            if recentDate != displayDate {
                localChatObj.showDateHeader = true
                localChatObj.dateHeader = displayDate
                recentDate = displayDate
            }
            
            if showCustomerProfilePic && !isCurrentUser {
                showCustomerProfilePic = false
            }
            return localChatObj
        }
        
        realtimeDBRef.observeForAdded { (datasnapshot) in
            let chatObj = SnapshotDecoder.decodeSnapshot(modelType: ChatMessage.self, snapshot: datasnapshot)
            if chatObj != nil && chatObj?.appointmentId == self.appointment.appointmentID {
                let localChatObj = makeChatObj(chatObj: chatObj!)
                self.messageList.append(localChatObj)
                self.scrollToBottomListener.toggle()
            }

            self.messageList.sort {
                $0.chatMessage.timeStamp < $1.chatMessage.timeStamp
            }
        }
    }

    public func makeMessage() -> ChatMessage {
        return ChatMessage(messageId: UUID().uuidString, message: currentTextEntry, senderId: appointment.customerID, timeStamp: Date().millisecondsSince1970, appointmentId: appointment.appointmentID, serviceProviderId: appointment.serviceProviderID, customerId: appointment.customerID)
    }

    public func writeMessage () {
        guard !currentTextEntry.isEmpty else { return }

        var message = makeMessage()
        self.currentTextEntry = ""
        
        dbRef.getSpecificChatRefToWrite() { dbRef, keyId in
            let dbWriter = RealtimeDBWriter(dbRef: dbRef)
            message.messageId = keyId
            dbWriter.writeData(object: message)
            customerNotifHelpers.chatNotif(message: message.message)
            //TODO: Fire notif for each new chat
        }
    }

    public func checkIfMessageIsFromCurrentUser (message:ChatMessage) -> Bool {
        if message.senderId == UserIdHelper().retrieveUserId() {
            return true
        } else {
            return false
        }
    }

    public func preSetMessageSelected (message:String) {
        currentTextEntry = message
        writeMessage()
    }
}

