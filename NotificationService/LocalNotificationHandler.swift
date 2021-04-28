//
//  LocalNotificationSender.swift
//  NambaDoctor
//
//  Created by Surya Manivannan on 19/12/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import Foundation
import UIKit

enum NotifTypes: String, Codable {
    case AppointmentBooked
    case AppointmentCancelled
    case ReportUploaded
    case Paid
    case CallInRoom
    case NewChatMessage
    case Empty
}

func getNotifType(type:String) -> NotifTypes {
    switch type {
    case NotifTypes.AppointmentBooked.rawValue:
        return .AppointmentBooked
    case NotifTypes.AppointmentCancelled.rawValue:
        return .AppointmentCancelled
    case NotifTypes.ReportUploaded.rawValue:
        return .ReportUploaded
    case NotifTypes.Paid.rawValue:
        return .Paid
    case NotifTypes.CallInRoom.rawValue:
        return .CallInRoom
    case NotifTypes.NewChatMessage.rawValue:
        return .NewChatMessage
    default:
        return .Empty
    }
}

class LocalNotificationHandler {
    
    func notifRecieveHelper (userInfo: [AnyHashable: Any], completion: @escaping (_ fire:Bool)->()) {
        let body = userInfo[AnyHashable("body")]
        let title = userInfo[AnyHashable("title")]
        let id = userInfo[AnyHashable("id")]
        let type = (userInfo[AnyHashable("type")] ?? "") as! String
        print("NOTIF RECIEVED")
        guard body != nil, title != nil else { return }
   
        let notifType = getNotifType(type: type)
        
        LocalNotifStorer().storeLocalNotif(title: title as! String, body: body as! String, appointmentId: id as! String, notifType: notifType)
        
        print("notif type: \(notifType)")
        
        switch notifType {
        case .AppointmentBooked, .AppointmentCancelled:
            DoctorDefaultModifiers.refreshAppointments()
            completion(true)
        case .ReportUploaded:
            DoctorDefaultModifiers.refreshReportsForDoctor()
            completion(false)
        case .Paid:
            completion(true)
            break
        case .CallInRoom, .NewChatMessage:
            completion(true)
        default:
            completion(true)
        }
        LoggerService().log(appointmentId: "", eventName: "PROCESSED NOTIFICATION")
    }

    func notifTappedHelper (userInfo: [AnyHashable: Any]) {
        let body = userInfo[AnyHashable("body")]
        let title = userInfo[AnyHashable("title")]
        let id = userInfo[AnyHashable("id")]
        let type = (userInfo[AnyHashable("type")] ?? "") as! String
        
        guard body != nil, title != nil else { return }
        
        let notifType = getNotifType(type: type)

        switch notifType {
        case .AppointmentBooked, .AppointmentCancelled:
            DoctorDefaultModifiers.refreshAppointments()
        case .Paid, .ReportUploaded :
            break
        case .CallInRoom:
            docAutoNav.navigateToCall(appointmentId: id as! String)
            break
        case .NewChatMessage:
            docAutoNav.navigateToChat(appointmentId: id as! String)
            break
        default:
            break
        }
    }
    
    func notifTappedHelper (notifObj: LocalNotifObj) {
        switch notifObj.NotifType {
        case .AppointmentBooked, .AppointmentCancelled:
            DoctorDefaultModifiers.refreshAppointments()
        case .Paid, .ReportUploaded :
            break
        case .CallInRoom:
            docAutoNav.navigateToCall(appointmentId: notifObj.AppointmentId)
            break
        case .NewChatMessage:
            docAutoNav.navigateToChat(appointmentId: notifObj.AppointmentId)
            break
        default:
            break
        }
        LoggerService().log(appointmentId: "", eventName: "TAPPED NOTIFICATION")
    }
}

class FireLocalNotif {
    func fire (userInfo:[AnyHashable: Any]) {
        let body = userInfo[AnyHashable("body")] as! String
        let title = userInfo[AnyHashable("title")] as! String

        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = body
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
}
