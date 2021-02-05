//
//  SendNotificationHelpers.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 20/01/21.
//

import Foundation

class DocNotifHelpers {
    
    var currentDocObj:Nambadoctor_V1_DoctorResponse
    
    init() {
        currentDocObj = GetDocObject.docHelper.getDoctor()
    }
    
    func fireCancelNotif (patientToken:String, appointmentTime:String) {
        let cancelNotifObj = Nambadoctor_V1_NotificationRequest.with {
            $0.title = "Your Appointment Cancelled"
            $0.body = "\(currentDocObj.fullName) has cancelled the appointment at \(appointmentTime)"
            $0.receiverDeviceToken = patientToken
            $0.idIfAny = ""
        }
        SendPushNotification.sendNotif(notifObj: cancelNotifObj)
    }

    func fireStartedConsultationNotif (patientToken:String, appointmentTime:String) {
        
        let startedConsultNotifObj = Nambadoctor_V1_NotificationRequest.with {
            $0.title = "Dr \(currentDocObj.fullName) is calling you"
            $0.body = "Please answer the call"
            $0.receiverDeviceToken = patientToken
            $0.idIfAny = ""
        }
        
        SendPushNotification.sendNotif(notifObj: startedConsultNotifObj)
    }
    
    func fireAppointmentOverNotif(patientToken: String) {
        let startedConsultNotifObj = Nambadoctor_V1_NotificationRequest.with {
            $0.title = "Appointment is over"
            $0.body = "Please complete your payment to continue"
            $0.receiverDeviceToken = patientToken
            $0.idIfAny = ""
        }
        
        SendPushNotification.sendNotif(notifObj: startedConsultNotifObj)
    }

}
