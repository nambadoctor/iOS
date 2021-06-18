//
//  DBReferences.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/14/21.
//

import Foundation
import FirebaseDatabase

class ChatDatabaseReference {
    var ref:DatabaseReference
    
    init(serviceProviderId:String, customerId:String) {
        ref = Database.database().reference().child("Chats").child("\(serviceProviderId)-\(customerId)")
    }
    
    func getChatToReadRefForServiceProvider (serviceProviderId:String, customerId:String) -> DatabaseQuery {
        return ref.queryOrdered(byChild: "serviceProviderId").queryEqual(toValue: serviceProviderId)
    }

    func getSpecificChatRefToWrite (completion: (_ dbRef:DatabaseReference, _ keyId:String)->()) {
        let keyId = ref.childByAutoId().key!
        let dbRef = ref.child(keyId)
        completion(dbRef, keyId)
    }
}

class AppointmentStatusDatabaseReference {
    var ref:DatabaseReference
    
    init(appointmentId:String) {
        ref = Database.database().reference().child("AppointmentStatus").child(appointmentId)
    }
    
    func getChatToReadRefForServiceProvider (serviceProviderId:String, customerId:String) -> DatabaseQuery {
        return ref
    }

    func getSpecificChatRefToWrite (completion: (_ dbRef:DatabaseReference, _ keyId:String)->()) {
        let keyId = ref.childByAutoId().key!
        completion(ref, keyId)
    }
}
