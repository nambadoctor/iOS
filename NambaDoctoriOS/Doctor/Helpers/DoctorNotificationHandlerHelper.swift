//
//  DoctorNotificationHandlerHelper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/13/21.
//

import Foundation

class DoctorNotificationHandlerHelper {
    func appointmentNotif () {
        if !docAutoNav.currenltyInIntermediateView {
            DoctorDefaultModifiers.refreshAppointments()
        }
    }
}
