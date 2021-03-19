//
//  SendPushNotifications.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 20/01/21.
//

import Foundation

class SendPushNotification {
    func sendNotif (notifObj: Nd_V1_NotificationRequestMessage) {
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let notificiationClient = Nd_V1_NotificationWorkerV1Client(channel: channel)
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        let request = notifObj
        
        let sendNotifTask = notificiationClient.sendNotification(request, callOptions: callOptions)

        do {
            let response = try sendNotifTask.response.wait()
            print("Send Notification Client Success")
        } catch {
            print("Send Notification Client Failure")
        }
    }
}
