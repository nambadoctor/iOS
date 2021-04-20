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
        NotificationCenter.default.post(name: NSNotification.Name(DocViewStatesK.refreshAppointmentsChange.rawValue), object: nil)
    }
    
    static func navigateToClickedNotif () {
        UserDefaults.standard.set(true, forKey: DocViewStatesK.navigateToIntermediateView.rawValue)
        NotificationCenter.default.post(name: NSNotification.Name(DocViewStatesK.navigateToIntermediateViewChange.rawValue), object: nil)
    }
    
    static func updateFCMToken () {
        UserDefaults.standard.set(true, forKey: DocViewStatesK.FCMTokenUpdate.rawValue)
        NotificationCenter.default.post(name: NSNotification.Name(DocViewStatesK.FCMTokenUpdate.rawValue), object: nil)
    }
    
    //MARK: DO NOT SHOW FOR END CONSULTATION ALERT
    static func endConsultAlertDoNotShow () {
        UserDefaults.standard.set(true, forKey: "\(DocViewStatesK.endConsultationAlert)")
        NotificationCenter.default.post(name: NSNotification.Name("\(DocViewStatesK.endConsultationAlertChange)"), object: nil)
    }

    static func refreshReportsForDoctor () {
        UserDefaults.standard.set(true, forKey: "\(DocViewStatesK.refreshReports)")
        NotificationCenter.default.post(name: NSNotification.Name("\(DocViewStatesK.refreshReportsChange)"), object: nil)
    }
}
