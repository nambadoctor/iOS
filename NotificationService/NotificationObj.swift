//
//  NotificationObj.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 20/01/21.
//

import Foundation

struct NotificationObj {
    internal init(token: String, title: String, body: String, id: String) {
        self.token = token
        self.title = title
        self.body = body
        self.id = id
    }
    
    var token:String
    var title:String
    var body:String
    var id:String
}
