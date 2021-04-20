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
        alertTempItem = AlertItem(title: Text("Save your progress!"), message: Text("You can save this prescription and finish it at your convenience"), primaryButton: Alert.Button.default(Text("Save and go back"), action: {
            save(true)
        }), secondaryButton: Alert.Button.default(Text("Don't save and go back"), action: {
            save(false)
        }))

        CommonDefaultModifiers.showAlert()
    }
    
    func cancelAppointmentAlert (cancel: @escaping (Bool) -> ()) {
        alertTempItem = AlertItem(title: Text("Are you sure?"), message: Text("Do you want to cancel this appointment?"), primaryButton: Alert.Button.default(Text("Yes"), action: {
            cancel(true)
        }), secondaryButton: Alert.Button.cancel(Text("No")))
        
        CommonDefaultModifiers.showAlert()
    }

    func endConsultationAlert (endConsultation: @escaping (Bool) -> ()) {
        alertTempItem = AlertItem(title: Text("Are you sure?"), message: Text("You will not be able to join consultation room again!"), primaryButton: Alert.Button.default(Text("No")), secondaryButton: Alert.Button.default(Text("Yes"), action: {
            endConsultation(true)
        }))
        
        CommonDefaultModifiers.showAlert()
    }
    
    func isSavedAlert () {
        alertTempItem = AlertItem(title: Text("Successfully Saved"), dismissButton: .default(Text("OK")))
        CommonDefaultModifiers.showAlert()
    }
    
    func patientAddedAlert () {
        alertTempItem = AlertItem(title: Text("Patint Added"), message: Text("this patient has been successfully added"), dismissButton: .default(Text("OK")))
        CommonDefaultModifiers.showAlert()
    }
    
    func prescriptionWriteSuccessAlert () {
        alertTempItem = AlertItem(title: Text("Success"), message: Text("Your prescription has been saved successfully."), dismissButton: .default(Text("OK")))
        CommonDefaultModifiers.showAlert()
    }
    
    func twilioConnectToRoomAlert (connect: @escaping (Bool) -> ()) {
        alertTempItem = AlertItem(title: Text("Would you like to connect to the consultation room?"), primaryButton: Alert.Button.cancel({
            docAutoNav.clearAllValues()
        }), secondaryButton: Alert.Button.default(Text("Yes"), action: {
            connect(true)
        }))
        CommonDefaultModifiers.showAlert()
    }
    
    func takeToChatAlert (open: @escaping (Bool) -> ()) {
        alertTempItem = AlertItem(title: Text("Would you like to open this chat?"), primaryButton: Alert.Button.cancel({
            docAutoNav.clearAllValues()
        }), secondaryButton: Alert.Button.default(Text("Yes"), action: {
            open(true)
        }))
        CommonDefaultModifiers.showAlert()
    }

}
