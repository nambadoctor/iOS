//
//  DoctorSheetHelpers.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 24/01/21.
//

import Foundation

class DoctorSheetHelpers {
    static func showPatientInfoSheet (appointment:Appointment) {
        let tempSheetItem = DoctorSheetItem(id: UUID(), appointment: appointment)
        sheetTempItem = tempSheetItem
        
        UserDefaults.standard.set(true, forKey: "\(SimpleStateK.showSheeet)")
        NotificationCenter.default.post(name: NSNotification.Name("\(SimpleStateK.showSheetChange)"), object: nil)
    }
}
