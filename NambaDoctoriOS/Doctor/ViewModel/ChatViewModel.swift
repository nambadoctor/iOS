//
//  ChatViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/14/21.
//

import Foundation

class ChatViewModel: ObservableObject {
    private var appointment:ServiceProviderAppointment
    private var realtimeDBRef:RealtimeDBListener
    
    @Published var messageList:[ChatMessage] = [ChatMessage]()
    @Published var currentTextEntry:String = ""
    

    init(appointment:ServiceProviderAppointment) {
        self.appointment = appointment
        self.realtimeDBRef = RealtimeDBListener(dbQuery: DBReferences().getChatToReadRefForServiceProvider(serviceProviderId: appointment.serviceProviderID))
        
        startMessageAddedListener()
    }

    private func startMessageAddedListener () {
        realtimeDBRef.observeForAdded { (datasnapshot) in
            let chatObj = SnapshotDecoder.decodeSnapshot(modelType: ChatMessage.self, snapshot: datasnapshot)

            if chatObj != nil {
                self.messageList.append(chatObj!)
            }
        }
    }

    public func makeMessage() -> ChatMessage {
        return ChatMessage(messageId: UUID().uuidString, message: currentTextEntry, senderId: appointment.serviceProviderID, timeStamp: Date().millisecondsSince1970, appointmentId: appointment.appointmentID, serviceProviderId: appointment.serviceProviderID, customerId: appointment.customerID)
    }

    public func writeMessage () {
        
        guard !currentTextEntry.isEmpty else { return }
        
        let message = makeMessage()
        self.currentTextEntry = ""
        
        let dbWriter = RealtimeDBWriter(dbRef: DBReferences().getSpecificChatRefToWrite(messageId: message.messageId))

        dbWriter.writeData(object: message)
    }
    
    public func checkIfMessageIsFromCurrentUser (message:ChatMessage) -> Bool {
        if message.senderId == UserIdHelper().retrieveUserId() {
            return true
        } else {
            return false
        }
    }
}
