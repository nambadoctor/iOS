//
//  FireLocalNotification.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/13/21.
//

import Foundation
import UIKit

var showRepeatingCallNotif:Bool = false

class FireLocalNotif {
    func fire (userInfo:[AnyHashable: Any]) {
        let body = userInfo[AnyHashable("body")] as? String
        let title = userInfo[AnyHashable("title")] as? String
        
        let warning = userInfo[AnyHashable("title")] as? String
        
        guard warning != nil else { return }

        let content = UNMutableNotificationContent()
        content.title = "\(title ?? "")"
        content.subtitle = "\(body ?? "")"
        content.userInfo = userInfo
        content.sound = UNNotificationSound.default
        
        // show this notification five seconds from now
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)

        // choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        // add our notification request
        UNUserNotificationCenter.current().add(request)
        LoggerService().log(appointmentId: "", eventName: "DISPLAYED NOTIFICATION")
    }
    
    func fireRepeatingNotification (userInfo:[AnyHashable: Any]) {
        showRepeatingCallNotif = true
        let timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { timer in
            if showRepeatingCallNotif {
                self.fire(userInfo: userInfo)
            } else {
                timer.invalidate()
            }
        }
    }
}
