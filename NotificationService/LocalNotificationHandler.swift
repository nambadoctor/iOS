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
    case CallInType
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
    case NotifTypes.CallInType.rawValue:
        return .CallInType
    case NotifTypes.NewChatMessage.rawValue:
        return .NewChatMessage
    default:
        return .Empty
    }
}

struct LocalNotifObj : Codable {
    var Title:String
    var Body:String
    var NotifType:NotifTypes
    var AppointmentId:String
}

class LocalNotifStorer {
    func storeLocalNotif (title:String, body:String, appointmentId:String, notifType:NotifTypes) {
        var localNotifObj:LocalNotifObj = LocalNotifObj(Title: "", Body: "", NotifType: notifType, AppointmentId: appointmentId)

        switch notifType {
        case .AppointmentBooked, .AppointmentCancelled:
            localNotifObj.Title = title
            localNotifObj.Body = body
            localNotifObj.AppointmentId = appointmentId
            break
        case .ReportUploaded:
            break
        case .Paid:
            break
        case .CallInType:
            break
        case .NewChatMessage:
            break
        default:
            break
        }
    }
}

class LocalNotificationHandler {
    
    func notifRecieveHelper (userInfo: [AnyHashable: Any], completion: @escaping (_ fire:Bool)->()) {
        let body = userInfo[AnyHashable("body")]
        let title = userInfo[AnyHashable("title")]
        let type = (userInfo[AnyHashable("type")] ?? "") as! String
        guard body != nil, title != nil else { return }
        
        let notifType = getNotifType(type: type)
        
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
        case .CallInType, .NewChatMessage:
            completion(true)
        default:
            completion(true)
        }

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
        case .CallInType:
            docAutoNav.navigateToCall(appointmentId: id as! String)
            break
        case .NewChatMessage:
            docAutoNav.navigateToChat(appointmentId: id as! String)
            break
        default:
            break
        }
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
    }
}
