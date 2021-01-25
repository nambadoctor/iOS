//
//  DoctorDefaultModifiers.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 20/01/21.
//

import Foundation

class DoctorDefaultModifiers {
    //MARK: REFRESH APPOINTMENTS
    static func refreshAppointments () {
        UserDefaults.standard.set(true, forKey: DocViewStatesK.toRefreshAppointments.rawValue)
        NotificationCenter.default.post(name: NSNotification.Name(DocViewStatesK.refreshAppointments.rawValue), object: nil)
    }
    
    //MARK: DO NOT SHOW FOR END CONSULTATION ALERT
    static func endConsultAlertDoNotShow () {
        UserDefaults.standard.set(true, forKey: "\(DocViewStatesK.endConsultationAlert)")
        NotificationCenter.default.post(name: NSNotification.Name("\(DocViewStatesK.endConsultationAlertChange)"), object: nil)
    }
}
