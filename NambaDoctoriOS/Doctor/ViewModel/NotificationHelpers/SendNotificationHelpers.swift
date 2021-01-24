//
//  SendNotificationHelpers.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 20/01/21.
//

import Foundation

class DocNotifHelpers {
    
    var currentDocObj:Doctor
    
    init() {
        currentDocObj = LocalDecoder.decode(modelType: Doctor.self, from: LocalEncodingK.userObj.rawValue)!
    }
    
    func fireCancelNotif (patientToken:String, appointmentTime:String) {
        let cancelNotifObj = NotificationObj(token: patientToken, title: "Your Appointment Cancelled", body: "\(currentDocObj.fullName) has cancelled the appointment at \(appointmentTime)", id: "")
        SendPushNotification.sendNotif(notifObj: cancelNotifObj)
    }

    func fireStartedConsultationNotif (patientToken:String, appointmentTime:String) {
        let startedConsultNotifObj = NotificationObj(token: patientToken, title: "Dr \(currentDocObj.fullName) is calling you", body: "Please answer the call", id: "")
        
        SendPushNotification.sendNotif(notifObj: startedConsultNotifObj)
    }
    
    func fireAppointmentOverNotif(patientToken: String) {
        let startedConsultNotifObj = NotificationObj(token: patientToken, title: "Appointment is over", body: "Please complete your payment to continue", id: "")
        
        SendPushNotification.sendNotif(notifObj: startedConsultNotifObj)
    }

}
