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

        let values = ApnPayloadDecoder().getValuesFromAPNPayload(userInfo: userInfo)

        let notifType = getNotifType(type: values[APNPayloadKeys.type.rawValue]!)
        
        LocalNotifStorer().storeLocalNotif(title: values[APNPayloadKeys.title.rawValue]!,
                                           body: values[APNPayloadKeys.body.rawValue]!,
                                           appointmentId: values[APNPayloadKeys.id.rawValue]!, notifType: notifType)
        
        switch notifType {
        case .AppointmentBooked, .AppointmentCancelled:
            DoctorNotificationHandlerHelper().appointmentNotif()
            CustomerNotificationHandlerHelper().appointmentNotif()
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
            CustomerNotificationHandlerHelper().callNotif(appointmentId: values[APNPayloadKeys.id.rawValue]!, userInfo: userInfo)
            completion(true)
        case .NewChatMessage:
            CommonDefaultModifiers.refreshChatCount()
            completion(true)
        default:
            completion(true)
        }

        LoggerService().log(eventName: "PROCESSED NOTIFICATION")
    }

    func notifTappedHelper (userInfo: [AnyHashable: Any]) {
        let values = ApnPayloadDecoder().getValuesFromAPNPayload(userInfo: userInfo)

        let notifType = getNotifType(type: values[APNPayloadKeys.type.rawValue]!)
        let id = values[APNPayloadKeys.id.rawValue]!

        switch notifType {
        case .AppointmentBooked:
            docAutoNav.navigateToAppointment(appointmentId: id)
            DoctorDefaultModifiers.refreshAppointments()
        case .AppointmentCancelled:
            DoctorDefaultModifiers.refreshAppointments()
        case .Paid :
            break
        case .ReportUploaded:
            docAutoNav.navigateToAppointment(appointmentId: id)
        case .CallInRoom:
            docAutoNav.navigateToCall(appointmentId: id)
            cusAutoNav.navigateToCall(appointmentId: id)
            break
        case .NewChatMessage:
            docAutoNav.navigateToChat(appointmentId: id)
            cusAutoNav.navigateToChat(appointmentId: id)
            break
        default:
            break
        }
        LoggerService().log(eventName: "TAPPED NOTIFICATION")
    }

    func notifTappedHelper (notifObj: LocalNotifObj) {
        switch notifObj.NotifType {
        case .AppointmentBooked:
            docAutoNav.navigateToAppointment(appointmentId: notifObj.AppointmentId)
            DoctorDefaultModifiers.refreshAppointments()
        case .AppointmentCancelled:
            DoctorDefaultModifiers.refreshAppointments()
        case .Paid:
            break
        case .ReportUploaded:
            docAutoNav.navigateToAppointment(appointmentId: notifObj.AppointmentId)
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
        LoggerService().log(eventName: "TAPPED NOTIFICATION")
    }
}
