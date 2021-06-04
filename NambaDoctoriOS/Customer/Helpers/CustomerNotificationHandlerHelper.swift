//
//  CustomerNotificationHandlerHelper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/23/21.
//

import Foundation

class CustomerNotificationHandlerHelper {
    func appointmentNotif () {
        if !cusAutoNav.currenltyInIntermediateView {
            CustomerDefaultModifiers.refreshAppointments()
        }
    }
    
    func callNotic (appointmentId:String, userInfo:[AnyHashable:Any]) {
        if cusAutoNav.currenltyInIntermediateView && cusAutoNav.appointmentId == appointmentId {
            cusAutoNav.navigateToCall(appointmentId: appointmentId)
        } else if !cusAutoNav.currentlyInTwilioRoom && !cusAutoNav.currenltyInIntermediateView && cusAutoNav.appointmentId.isEmpty {
            if UserTypeHelper.checkIfCustomer(userType: UserTypeHelper.getUserType()) && showRepeatingCallNotif == false {
                showRepeatingCallNotif = true
                FireLocalNotif().fireRepeatingNotification(userInfo: userInfo)
            }
            cusAutoNav.callNotifRecieved(appointmentId: appointmentId)
        }
    }
}
