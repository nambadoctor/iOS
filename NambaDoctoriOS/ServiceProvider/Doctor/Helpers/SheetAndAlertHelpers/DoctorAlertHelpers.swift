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
    
    func cancelAppointmentBeforePaymentAlert (cancel: @escaping (Bool) -> ()) {
        alertTempItem = AlertItem(title: Text("Are you sure?"), message: Text("Do you want to cancel now?"), primaryButton: Alert.Button.default(Text("Yes"), action: {
            cancel(true)
        }), secondaryButton: Alert.Button.cancel(Text("No")))
        
        CommonDefaultModifiers.showAlert()
    }

    func sendPrescriptionAlert (sendPrescription: @escaping (Bool) -> ()) {
        alertTempItem = AlertItem(title: Text("Are you ready to send this prescription to the patient?"), primaryButton: Alert.Button.default(Text("Cancel"), action: {
            sendPrescription(false)
        }), secondaryButton: Alert.Button.default(Text("Yes"), action: {
            sendPrescription(true)
        }))
        
        CommonDefaultModifiers.showAlert()
    }
    
    func isSavedAlert () {
        alertTempItem = AlertItem(title: Text("Successfully Saved"), dismissButton: .default(Text("OK")))
        CommonDefaultModifiers.showAlert()
    }

    func prescriptionWriteSuccessAlert () {
        alertTempItem = AlertItem(title: Text("Success"), message: Text("Your prescription has been saved successfully."), dismissButton: .default(Text("OK")))
        CommonDefaultModifiers.showAlert()
    }
    
    
    func customerVitalsSavedAlert () {
        alertTempItem = AlertItem(title: Text("Success"), message: Text("Customer Vitals have been saved"), dismissButton: .default(Text("OK")))
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
    
    
    func patientUnavailableAlert (patientName:String, completion: @escaping (_ wait:Bool, _ call:Bool) -> ()) {
        alertTempItem = AlertItem(title: Text("\(patientName) is not able to join"), message: Text("Would you like to call them through phone?"), primaryButton: Alert.Button.default(Text("Wait"), action: {
            completion(true, false)
        }), secondaryButton: Alert.Button.default(Text("Call"), action: {
            completion(false, true)
        }))

        CommonDefaultModifiers.showAlert()
    }
    
    func errorRemovingAvailabilitySlotAlert() {
        alertTempItem = AlertItem(title: Text("Cannot remove this availability slot"), message: Text("Please try again"), dismissButton: .default(Text("OK")))
        CommonDefaultModifiers.showAlert()
    }
    
    func videoCallNotAllowedForChildAlert(call: @escaping (Bool) -> ()) {
        alertTempItem = AlertItem(title: Text("Video call not supported for this patient"), message: Text("Please do audio call"), dismissButton: .default(Text("OK"), action: {
            call(true)
        }))
        CommonDefaultModifiers.showAlert()
    }
    
    func callWillTerminateAfterSubmitAlert(completion: @escaping (_ goBack:Bool, _ submit:Bool) -> ()) {
        alertTempItem = AlertItem(title: Text("Submiting prescription will end call"), message: Text("Are you sure you want to end the call also?"), primaryButton: Alert.Button.destructive(Text("Cancel"), action: {
            completion(true, false)
        }), secondaryButton: Alert.Button.default(Text("Submit"), action: {
            completion(false, true)
        }))

        CommonDefaultModifiers.showAlert()
    }
    
    func errorRetrievingChild (completion: @escaping (Bool) -> ()) {
        alertTempItem = AlertItem(title: Text("Loading patient profile..."), dismissButton: .default(Text("Ok"), action: {
            completion(true)
        }))
        CommonDefaultModifiers.showAlert()
    }
    
    func patientAddedAlert (completion: @escaping (_ dismiss:Bool, _ scheduleAppointment:Bool) -> ()) {
        alertTempItem = AlertItem(title: Text("Patient Added Successfully"), message: Text("If you would like to schedule an appointment for this patient, please click Schedule Appointment below"), primaryButton: Alert.Button.default(Text("Schedule Appointment"), action: {
            completion(false, true)
        }), secondaryButton: Alert.Button.default(Text("Dismiss"), action: {
            completion(true, false)
        }))

        CommonDefaultModifiers.showAlert()
    }
    
    func cannotAddPhoneNumberAlert (completion: @escaping (_ dismiss:Bool, _ contactSupport:Bool) -> ()) {
        alertTempItem = AlertItem(title: Text("Oops! Cannot add this phone number"), message: Text("Please double check the number or contact support"), primaryButton: Alert.Button.default(Text("Contact Support"), action: {
            completion(false, true)
        }), secondaryButton: Alert.Button.default(Text("Cancel"), action: {
            completion(true, false)
        }))

        CommonDefaultModifiers.showAlert()
    }
}
