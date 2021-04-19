//
//  LocalNotificationSender.swift
//  NambaDoctor
//
//  Created by Surya Manivannan on 19/12/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import Foundation
import UIKit

enum NotifTypes:String {
    case AppointmentBooked
    case AppointmentCancelled
    case ReportUploaded
    case Paid
    case CallInRoom
    case NewChatMessage
}

class LocalNotificationSender {
    
    func notifRecieveHelper (userInfo: [AnyHashable: Any]) {
        let body = userInfo[AnyHashable("body")]
        let title = userInfo[AnyHashable("title")]
        let type = (userInfo[AnyHashable("type")] ?? "") as! String
        
        guard body != nil, title != nil else { return }
        
        switch type {
        case NotifTypes.AppointmentBooked.rawValue:
            fireLocalNotif(title: title as! String, subtitle: body as! String)
            DoctorDefaultModifiers.refreshAppointments()
            break
        case NotifTypes.AppointmentCancelled.rawValue:
            fireLocalNotif(title: title as! String, subtitle: body as! String)
            DoctorDefaultModifiers.refreshAppointments()
            break
        case NotifTypes.ReportUploaded.rawValue:
            fireLocalNotif(title: title as! String, subtitle: body as! String)
            break
        case NotifTypes.Paid.rawValue:
            fireLocalNotif(title: title as! String, subtitle: body as! String)
            break
        case NotifTypes.CallInRoom.rawValue:
            fireLocalNotif(title: title as! String, subtitle: body as! String)
            break
        case NotifTypes.NewChatMessage.rawValue:
            fireLocalNotif(title: title as! String, subtitle: body as! String)
            break
        default:
            break
        }
    }

    func fireLocalNotif (title:String, subtitle:String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.sound = UNNotificationSound.default

        // show this notification five seconds from now
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)

        // choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        // add our notification request
        UNUserNotificationCenter.current().add(request)
    }
}
