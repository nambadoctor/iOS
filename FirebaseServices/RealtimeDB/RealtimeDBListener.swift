//
//  RealtimeDBListener.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/14/21.
//

import Foundation
import FirebaseDatabase

class RealtimeDBListener {
    var query: DatabaseQuery!
    
    init(dbQuery:DatabaseQuery) {
        query = dbQuery
    }
    
    func valueListener (completion: @escaping (_ snapshot:DataSnapshot)->()) {
        query.observe(DataEventType.value, with: { (snapshot) in
            completion(snapshot)
        })
    }

    func observeForAdded (completion: @escaping (_ snapshot:DataSnapshot)->()) {
        query.observe(.childAdded, with: { (snapshot) -> Void in
            completion(snapshot)
        })
    }

    func observeForChanged (completion: @escaping (_ snapshot:DataSnapshot)->()) {
        query.observe(.childChanged, with: { (snapshot) -> Void in
            completion(snapshot)
        })
    }
    
    func observeForRemoved (completion: @escaping (_ snapshot:DataSnapshot)->()) {
        query.observe(.childRemoved, with: { (snapshot) -> Void in
            completion(snapshot)
        })
    }
}
