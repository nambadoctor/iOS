//
//  ChatViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/14/21.
//

import Foundation

class DoctorChatViewModel: ObservableObject {
    var appointment:ServiceProviderAppointment
    
    private var dbRef:DBReferences
    private var realtimeDBRef:RealtimeDBListener

    @Published var messageList:[ChatMessage] = [ChatMessage]()
    @Published var currentTextEntry:String = ""

    @Published var takeToBottomListener:String = ""
    
    init(appointment:ServiceProviderAppointment) {
        self.appointment = appointment
        self.dbRef = DBReferences(serviceProviderId: appointment.serviceProviderID, customerId: appointment.customerID)
        self.realtimeDBRef = RealtimeDBListener(dbQuery: dbRef.getChatToReadRefForServiceProvider(serviceProviderId: appointment.serviceProviderID, customerId: appointment.customerID))

        startMessageAddedListener()
    }

    private func startMessageAddedListener () {
        realtimeDBRef.observeForAdded { (datasnapshot) in
            let chatObj = SnapshotDecoder.decodeSnapshot(modelType: ChatMessage.self, snapshot: datasnapshot)
            if chatObj != nil && chatObj?.appointmentId == self.appointment.appointmentID {
                self.messageList.append(chatObj!)
                self.takeToBottomListener = UUID().uuidString
            }

            self.messageList.sort {
                $0.timeStamp < $1.timeStamp
            }
        }
    }

    public func makeMessage() -> ChatMessage {
        return ChatMessage(messageId: UUID().uuidString, message: currentTextEntry, senderId: appointment.serviceProviderID, timeStamp: Date().millisecondsSince1970, appointmentId: appointment.appointmentID, serviceProviderId: appointment.serviceProviderID, customerId: appointment.customerID)
    }

    public func writeMessage () {
        print("CURRENT TEXT ENTRY: \(currentTextEntry)")
        guard !currentTextEntry.isEmpty else { return }

        var message = makeMessage()
        self.currentTextEntry = ""
        
        dbRef.getSpecificChatRefToWrite() { dbRef, keyId in
            let dbWriter = RealtimeDBWriter(dbRef: dbRef)
            message.messageId = keyId
            dbWriter.writeData(object: message)
            DocNotifHelpers(appointment: appointment).fireChatMessageNotif(message: message.message)
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
