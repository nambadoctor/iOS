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

    func refreshAppointmentsListener () {
        NotificationCenter.default.addObserver(forName: NSNotification.Name("\(DocViewStatesK.refreshAppointmentsChange)"), object: nil, queue: .main) { (_) in
            doctorViewModel.loadView()
        }
    }
    
    func refreshFCMTokenListener () {
        NotificationCenter.default.addObserver(forName: NSNotification.Name("\(DocViewStatesK.FCMTokenUpdateChange)"), object: nil, queue: .main) { (_) in
            doctorViewModel.updateFCMToken()
        }
    }
}
