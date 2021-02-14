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

    func showLoadingScreenListener () {
        NotificationCenter.default.addObserver(forName: NSNotification.Name("\(SimpleStateK.showLoaderChange)"), object: nil, queue: .main) { (_) in
            self.showLoadingScreen = UserDefaults.standard.value(forKey: "\(SimpleStateK.showLoader)") as! Bool
        }
    }
}
