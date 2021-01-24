//
//  DoctorPopupHelpers.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 21/01/21.
//

import Foundation
import SwiftUI

class DoctorAlertHelpers: DoctorAlertHelpersProtocol {
    func writePrescriptionAlert (appointmentId:String, requestedBy:String, navigate: @escaping (Bool) -> ()) {
        alertTempItem = AlertItem(title: Text("Warning! End consultation and write prescription?"), message: Text("You will not be able to call patient in consulting room anymore"), primaryButton: Alert.Button.default(Text("Confirm"), action: {

            navigate(true)
            
        }), secondaryButton: Alert.Button.cancel(Text("Go Back")))

        CommonDefaultModifiers.showAlert()
    }

    func amendPrescriptionAlert (amend: @escaping (Bool) -> ()) {
        alertTempItem = AlertItem(title: Text("Amend Prescription?"), message: Text("When you amend this prescription an alert gets sent to the patient but old prescription is still saved as a record"), primaryButton: Alert.Button.default(Text("Continue"), action: {
            amend(true)
        }), secondaryButton: Alert.Button.cancel(Text("Cancel")))
        
        CommonDefaultModifiers.showAlert()
    }
    
    func askToSavePrescriptionAlert (save: @escaping (Bool) -> ()) {
        alertTempItem = AlertItem(title: Text("Do you want to save prescription?"), message: Text("You can save this prescription and finish it at your convenience"), primaryButton: Alert.Button.default(Text("Save and go to home"), action: {
            save(true)
        }), secondaryButton: Alert.Button.default(Text("Don't save and go to home"), action: {
            save(false)
        }))

        CommonDefaultModifiers.showAlert()
    }
}
