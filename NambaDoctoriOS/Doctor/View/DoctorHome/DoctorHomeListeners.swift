//
//  DoctorHomeListeners.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 11/02/21.
//

import Foundation

extension DoctorHome {
    func showAlertListener () {
        NotificationCenter.default.addObserver(forName: NSNotification.Name("\(SimpleStateK.showPopupChange)"), object: nil, queue: .main) { (_) in
            if alertTempItem != nil {
                self.alertItem = alertTempItem
            } else {
                self.alertItem = nil
            }
        }
    }
    
    func showSheetListener () {
        NotificationCenter.default.addObserver(forName: NSNotification.Name("\(SimpleStateK.showSheetChange)"), object: nil, queue: .main) { (_) in
            if sheetTempItem != nil {
                self.sheetItem = sheetTempItem
            }
        }
    }

    func refreshAppointmentsListener () {
        NotificationCenter.default.addObserver(forName: NSNotification.Name("\(DocViewStatesK.refreshAppointmentsChange)"), object: nil, queue: .main) { (_) in
            doctorViewModel.refreshAppointments()
        }
    }
    
    func refreshFCMToken () {
        NotificationCenter.default.addObserver(forName: NSNotification.Name("\(DocViewStatesK.FCMTokenUpdateChange)"), object: nil, queue: .main) { (_) in
            doctorViewModel.updateFCMToken()
        }
    }
}
