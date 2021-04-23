//
//  DoctorPopupHelpers.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 21/01/21.
//

import Foundation
import SwiftUI

class DoctorAlertHelpers: DoctorAlertHelpersProtocol {
    
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
    
    func presentingStackedNavViewError (navType:String) {
        alertTempItem = AlertItem(title: Text("Cannot Open"), message: Text("Sorry, you cannot open another \(navType) while currently in a meeting"), dismissButton: .default(Text("OK")))
        CommonDefaultModifiers.showAlert()
    }

    func editOrRemoveAvailabilityAlert (slotTime:String, completion: @escaping (_ edit:Bool, _ remove:Bool) -> ()) {
        alertTempItem = AlertItem(title: Text("Would you like to edit or remove this slot?"), message: Text("Slot: \(slotTime)"), primaryButton: Alert.Button.default(Text("Edit"), action: {
            completion(true, false)
        }), secondaryButton: Alert.Button.default(Text("Remove"), action: {
            completion(false, true)
        }))

        CommonDefaultModifiers.showAlert()
    }
    
    func errorRemovingAvailabilitySlotAlert() {
        alertTempItem = AlertItem(title: Text("Cannot remove this availability slot"), message: Text("Please try again"), dismissButton: .default(Text("OK")))
        CommonDefaultModifiers.showAlert()
    }
}
