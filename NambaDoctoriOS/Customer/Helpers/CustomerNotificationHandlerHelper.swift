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
    
    func callNotic (appointmentId:String) {
        if !cusAutoNav.currentlyInTwilioRoom {
            cusAutoNav.callNotifRecieved(appointmentId: appointmentId)
        }
    }
}
