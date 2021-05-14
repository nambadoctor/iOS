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
    case PrescriptionUploaded
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
    case NotifTypes.PrescriptionUploaded.rawValue:
        return .PrescriptionUploaded
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

        let values = getValuesFromAPNPayload(userInfo: userInfo)

        let notifType = getNotifType(type: values["type"]!)
        
        LocalNotifStorer().storeLocalNotif(title: values["title"]!, body: values["body"]!, appointmentId: values["id"]!, notifType: notifType)
        
        switch notifType {
        case .AppointmentBooked, .AppointmentCancelled:
            DoctorNotificationHandlerHelper().appointmentNotif()
            CustomerDefaultModifiers.refreshAppointments()
            completion(true)
        case .PrescriptionUploaded:
            CustomerDefaultModifiers.triggerAppointmentStatusChanges()
        case .ReportUploaded:
            DoctorDefaultModifiers.refreshReportsForDoctor()
            completion(false)
        case .Paid:
            completion(true)
            break
        case .CallInRoom:
            cusAutoNav.callNotifRecieved(appointmentId: values["id"]!)
            completion(true)
        case .NewChatMessage:
            CommonDefaultModifiers.refreshChatCount()
            completion(true)
        default:
            completion(true)
        }

        LoggerService().log(appointmentId: "", eventName: "PROCESSED NOTIFICATION")
    }

    func notifTappedHelper (userInfo: [AnyHashable: Any]) {
        let values = getValuesFromAPNPayload(userInfo: userInfo)

        let notifType = getNotifType(type: values["type"]!)

        switch notifType {
        case .AppointmentBooked:
            docAutoNav.navigateToAppointment(appointmentId: values["id"]!)
            DoctorDefaultModifiers.refreshAppointments()
        case .AppointmentCancelled:
            DoctorDefaultModifiers.refreshAppointments()
        case .Paid, .ReportUploaded :
            break
        case .CallInRoom:
            docAutoNav.navigateToCall(appointmentId: values["id"]!)
            cusAutoNav.navigateToCall(appointmentId: values["id"]!)
            break
        case .NewChatMessage:
            docAutoNav.navigateToChat(appointmentId: values["id"]!)
            cusAutoNav.navigateToChat(appointmentId: values["id"]!)
            break
        default:
            break
        }
        LoggerService().log(appointmentId: "", eventName: "TAPPED NOTIFICATION")
    }

    func notifTappedHelper (notifObj: LocalNotifObj) {
        switch notifObj.NotifType {
        case .AppointmentBooked:
            docAutoNav.navigateToAppointment(appointmentId: notifObj.AppointmentId)
            DoctorDefaultModifiers.refreshAppointments()
        case .AppointmentCancelled:
            DoctorDefaultModifiers.refreshAppointments()
        case .Paid, .ReportUploaded :
            break
        case .CallInRoom:
            docAutoNav.navigateToCall(appointmentId: notifObj.AppointmentId)
            cusAutoNav.navigateToCall(appointmentId: notifObj.AppointmentId)
            break
        case .NewChatMessage:
            docAutoNav.navigateToChat(appointmentId: notifObj.AppointmentId)
            cusAutoNav.navigateToChat(appointmentId: notifObj.AppointmentId)
            break
        default:
            break
        }
        LoggerService().log(appointmentId: "", eventName: "TAPPED NOTIFICATION")
    }

    private func getValuesFromAPNPayload (userInfo:[AnyHashable: Any]) -> [String:String] {
        let apnData = userInfo[AnyHashable("aps")] as! NSDictionary
        let alertData  = apnData["alert"] as! NSDictionary

        let body = alertData["body"] as! String
        let title = alertData["title"] as! String
        let type = alertData["type"] as! String
        let id = alertData["id"] as! String

        var returnDict:[String:String] = ["body":body, "title":title, "type":type, "id":id]

        return returnDict
    }
}
