//
//  DBReferences.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/14/21.
//

import Foundation
import FirebaseDatabase

class DBReferences {
    var ref = Database.database().reference()
    
    func getChatToReadRefForServiceProvider (serviceProviderId:String) -> DatabaseQuery {
        return ref.queryOrdered(byChild: "serviceProviderId").queryEqual(toValue: serviceProviderId)
    }

    func getSpecificChatRefToWrite (messageId:String) -> DatabaseReference {
        return ref.child(messageId)
    }
}

