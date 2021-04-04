//
//  SendNotificationHelpers.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 20/01/21.
//

import Foundation

class DocNotifHelpers : DocNotifHelpersProtocol {
    var appointment:ServiceProviderAppointment
    var sendPushNotification = NambaDoctoriOS.SendPushNotification()
    
    init(appointment:ServiceProviderAppointment) {
        self.appointment = appointment
    }

    func fireCancelNotif (requestedBy:String, appointmentTime:Int64) {
        
        let readableTime = Helpers.getTimeFromTimeStamp(timeStamp: appointmentTime)

        let cancelNotifObj = Nd_V1_NotificationRequestMessage.with {
            $0.title = "Your Appointment Cancelled".toProto
            $0.body = "\(appointment.serviceProviderName) has cancelled the appointment at \(readableTime)".toProto
            $0.userID = requestedBy.toProto
            $0.id = appointment.appointmentID.toProto
        }

        sendPushNotification.sendNotif(notifObj: cancelNotifObj)
    }

    func fireStartedConsultationNotif (requestedBy:String, appointmentTime:Int64) {
        
        let startedConsultNotifObj = Nd_V1_NotificationRequestMessage.with {
            $0.title = "Dr \(appointment.serviceProviderName) is calling you".toProto
            $0.body = "Please answer the call".toProto
            $0.userID = requestedBy.toProto
            $0.id = appointment.appointmentID.toProto
        }

        sendPushNotification.sendNotif(notifObj: startedConsultNotifObj)
    }
    
    func fireAppointmentOverNotif(requestedBy: String) {
        let startedConsultNotifObj = Nd_V1_NotificationRequestMessage.with {
            $0.title = "Prescription Added".toProto
            $0.body = "Please complete your payment to continue".toProto
            $0.userID = requestedBy.toProto
            $0.id = appointment.appointmentID.toProto
        }

        sendPushNotification.sendNotif(notifObj: startedConsultNotifObj)
    }
    
}
