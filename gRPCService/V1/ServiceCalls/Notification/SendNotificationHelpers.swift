//
//  SendNotificationHelpers.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 20/01/21.
//

import Foundation

class DocNotifHelpers : DocNotifHelpersProtocol {
    static var sharedNotifHelpers:DocNotifHelpers = DocNotifHelpers()
    var currentDocObj:ServiceProviderProfile
    var sendPushNotification = NambaDoctoriOS.SendPushNotification()
    var getDocObjectHelper:GetServiceProviderObjectProtocol
    var patientTokenId:String = ""
    
    init(getDocObjHelper:GetServiceProviderObjectProtocol = GetServiceProviderObject()) {
        self.getDocObjectHelper = getDocObjHelper
        currentDocObj = getDocObjectHelper.getServiceProvider()
    }
    
    func getPatientFCMTokenId (requestedBy:String, completion: @escaping (_ retrieved:Bool) -> ()) {
        if patientTokenId.isEmpty {
            DispatchQueue.main.async {
                GetReceptientFCMTokenId.getPatientTokenId(patientId: requestedBy) { (tokenId) in
                    if tokenId != nil {
                        completion(true)
                    } else {
                        completion(false)
                    }
                }
            }
        } else {
            completion(true)
        }
    }
    
    func fireCancelNotif (requestedBy:String, appointmentTime:Int64) {
        
        func makeObjAndFire() {
            let readableTime = Helpers.getTimeFromTimeStamp(timeStamp: appointmentTime)
            
            let cancelNotifObj = Nambadoctor_V1_NotificationRequest.with {
                $0.title = "Your Appointment Cancelled"
                $0.body = "\(currentDocObj.fullName) has cancelled the appointment at \(readableTime)"
                $0.receiverDeviceToken = patientTokenId
                $0.idIfAny = ""
            }

            sendPushNotification.sendNotif(notifObj: cancelNotifObj)
        }

        getPatientFCMTokenId(requestedBy: requestedBy) { (success) in
            if success {
                makeObjAndFire()
            }
        }
    }
    
    func fireStartedConsultationNotif (requestedBy:String, appointmentTime:Int64) {
        
        func makeObjAndFire() {
            let startedConsultNotifObj = Nambadoctor_V1_NotificationRequest.with {
                $0.title = "Dr \(currentDocObj.fullName) is calling you"
                $0.body = "Please answer the call"
                $0.receiverDeviceToken = patientTokenId
                $0.idIfAny = ""
            }
            
            sendPushNotification.sendNotif(notifObj: startedConsultNotifObj)
        }
        
        getPatientFCMTokenId(requestedBy: requestedBy) { (success) in
            if success {
                makeObjAndFire()
            }
        }
    }
    
    func fireAppointmentOverNotif(requestedBy: String) {
        func makeObjAndFire () {
            let startedConsultNotifObj = Nambadoctor_V1_NotificationRequest.with {
                $0.title = "Appointment is over"
                $0.body = "Please complete your payment to continue"
                $0.receiverDeviceToken = patientTokenId
                $0.idIfAny = ""
            }
            
            sendPushNotification.sendNotif(notifObj: startedConsultNotifObj)
        }
        
        getPatientFCMTokenId(requestedBy: requestedBy) { (success) in
            if success {
                makeObjAndFire()
            }
        }
    }
    
}
