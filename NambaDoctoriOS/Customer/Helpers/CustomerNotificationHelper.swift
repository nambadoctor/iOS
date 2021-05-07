//
//  CustomerNotificationHelper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/7/21.
//

import Foundation

class CustomerNotificationHelper {
    var appointment:CustomerAppointment
    
    init(appointment:CustomerAppointment) {
        self.appointment = appointment
    }
    
    func reportUploadedNotif () {
        let startedConsultNotifObj = Nd_V1_NotificationRequestMessage.with {
            $0.title = "Report Uploaded".toProto
            $0.body = "\(appointment.customerName) has uploaded a report".toProto
            $0.userID = appointment.serviceProviderID.toProto
            $0.id = appointment.appointmentID.toProto
        }
        
        SendPushNotification().sendNotif(notifObj: startedConsultNotifObj)
    }
    
    func callingNotif () {
        let startedConsultNotifObj = Nd_V1_NotificationRequestMessage.with {
            $0.title = "Patient in waiting room".toProto
            $0.body = "\(appointment.customerName) is in the meeting room".toProto
            $0.userID = appointment.serviceProviderID.toProto
            $0.id = appointment.appointmentID.toProto
        }
        
        SendPushNotification().sendNotif(notifObj: startedConsultNotifObj)
    }
    
    func chatNotif (message:String) {
        let startedConsultNotifObj = Nd_V1_NotificationRequestMessage.with {
            $0.title = "New Message from \(appointment.customerName)".toProto
            $0.body = message.toProto
            $0.userID = appointment.serviceProviderID.toProto
            $0.id = appointment.appointmentID.toProto
        }
        
        SendPushNotification().sendNotif(notifObj: startedConsultNotifObj)
    }
    
    func paidNotif (message:String) {
        let startedConsultNotifObj = Nd_V1_NotificationRequestMessage.with {
            $0.title = "Patient Paid".toProto
            $0.body = "\(appointment.customerName) has paid \(appointment.serviceFee)".toProto
            $0.userID = appointment.serviceProviderID.toProto
            $0.id = appointment.appointmentID.toProto
        }
        
        SendPushNotification().sendNotif(notifObj: startedConsultNotifObj)
    }
    
    func bookedAppointment (customerName:String,
                            dateDisplay:Int64,
                            appointmentId:String,
                            serviceProviderId:String) {
        let startedConsultNotifObj = Nd_V1_NotificationRequestMessage.with {
            $0.title = "New Appointment".toProto
            $0.body = "\(customerName) booked on \(Helpers.getTimeFromTimeStamp(timeStamp: dateDisplay))".toProto
            $0.userID = serviceProviderId.toProto
            $0.id = appointmentId.toProto
        }

        SendPushNotification().sendNotif(notifObj: startedConsultNotifObj)
    }
    
    func cancelledAppointment () {
        let startedConsultNotifObj = Nd_V1_NotificationRequestMessage.with {
            $0.title = "Appointment Cancelled".toProto
            $0.body = "\(appointment.customerName) has cancelled appointment on \(Helpers.getTimeFromTimeStamp(timeStamp: appointment.scheduledAppointmentStartTime))".toProto
            $0.userID = appointment.serviceProviderID.toProto
            $0.id = appointment.appointmentID.toProto
        }

        SendPushNotification().sendNotif(notifObj: startedConsultNotifObj)
    }
    
}
