//
//  SendPushNotifications.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 20/01/21.
//

import Foundation

class SendPushNotification {
    static func sendNotif (notifObj:NotificationObj) {
        let parameters: [String: Any] = [
            "token":notifObj.token,
            "title":notifObj.title,
            "body":notifObj.body,
            "id":notifObj.id
        ]

        ApiPostCall.post(parameters: parameters, extensionURL: "notification/send") { (success, notifResponse) in }
    }
}
