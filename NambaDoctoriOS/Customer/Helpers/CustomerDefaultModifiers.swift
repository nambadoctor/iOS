//
//  CustomerDefaultModifiers.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/8/21.
//

import Foundation

class CustomerDefaultModifiers {
    static func refreshAppointments () {
        UserDefaults.standard.set(true, forKey: CustomerViewStatesK.toRefreshAppointments.rawValue)
        NotificationCenter.default.post(name: NSNotification.Name(CustomerViewStatesK.refreshAppointmentsChange.rawValue), object: nil)
    }

    static func navigateToDetailedView () {
        UserDefaults.standard.set(true, forKey: CustomerViewStatesK.navigateToDetailedView.rawValue)
        NotificationCenter.default.post(name: NSNotification.Name(CustomerViewStatesK.navigateToDetailedViewChange.rawValue), object: nil)
    }
    
    static func triggerAppointmentStatusChanges () {
        UserDefaults.standard.set(true, forKey: CustomerViewStatesK.AppointmentStatus.rawValue)
        NotificationCenter.default.post(name: NSNotification.Name(CustomerViewStatesK.AppointmentStatusChange.rawValue), object: nil)
    }
}
