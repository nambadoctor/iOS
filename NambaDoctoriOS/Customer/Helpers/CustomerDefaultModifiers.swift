//
//  CustomerDefaultModifiers.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/8/21.
//

import Foundation

class CustomerDefaultModifiers {
    static func refreshAppointments () {
        UserDefaults.standard.set(true, forKey: CustomerViewStatesK.CustomerToRefreshAppointments.rawValue)
        NotificationCenter.default.post(name: NSNotification.Name(CustomerViewStatesK.CustomerRefreshAppointmentsChange.rawValue), object: nil)
    }

    static func navigateToDetailedView () {
        UserDefaults.standard.set(true, forKey: CustomerViewStatesK.CustomerNavigateToDetailedView.rawValue)
        NotificationCenter.default.post(name: NSNotification.Name(CustomerViewStatesK.CustomerNavigateToDetailedViewChange.rawValue), object: nil)
    }

    static func triggerAppointmentStatusChanges() {
        UserDefaults.standard.set(true, forKey: CustomerViewStatesK.CustomerAppointmentStatus.rawValue)
        NotificationCenter.default.post(name: NSNotification.Name(CustomerViewStatesK.CustomerAppointmentStatusChange.rawValue), object: nil)
    }
    
    static func takeToBookDoctor () {
        UserDefaults.standard.set(true, forKey: CustomerViewStatesK.CustomerNavigateToBookDoctor.rawValue)
        NotificationCenter.default.post(name: NSNotification.Name(CustomerViewStatesK.CustomerNavigateToBookDoctorChange.rawValue), object: nil)
    }
}
