//
//  SendPushNotifications.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 20/01/21.
//

import Foundation

class SendPushNotification {
    func sendNotif (notifObj: Nambadoctor_V1_NotificationRequest) {
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let notificiationClient = Nambadoctor_V1_NotificationWorkerV1Client(channel: channel)
        
        let request = notifObj
        
        let sendNotifTask = notificiationClient.sendNotification(request)
        
        do {
            let response = try sendNotifTask.response.wait()
            print("Send Notification Client Success")
        } catch {
            print("Send Notification Client Failure")
        }
    }
}
