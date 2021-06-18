//
//  RealtimeDBWriter.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/14/21.
//

import Foundation
import FirebaseDatabase

class RealtimeDBWriter {
    var ref: DatabaseReference!
    
    init(dbRef:DatabaseReference) {
        ref = dbRef
    }

    func writeData<T:Codable>(object: T) {
        ref.setValue(Helpers.ObjectAsDictionary(object: object))
    }
    
    func writeString (value:String) {
        ref.setValue(value)
    }
}
