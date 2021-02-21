//
//  AddPatientViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 25/01/21.
//

import Foundation

class AddPatientViewModel: ObservableObject {
    @Published var preRegisteredPatient:PreRegPatient
    @Published var followUpFeeObj:FollowUpAppointmentViewModel = FollowUpAppointmentViewModel()
    @Published var phoneNumObj:PhoneNumberObj = PhoneNumberObj()
    @Published var loadingScreen:Bool = false
    
    var allergies:String = ""
    var addPreRegPatient = AddPreRegisteredViewModel()
    var doctorAlertHelpers = DoctorAlertHelpers()

    init() {
        preRegisteredPatient = MakeEmptyPreRegPatient()
    }
    
    func addPatient (completion: @escaping (_ added:Bool)->()) {
        addPhoneNumberToPatientObj()
        
        guard emptyValuesCheck() else {
            GlobalPopupHelpers.fillAllFieldsAlert()
            //self.showLocalAlert.toggle()
            return
        }
        
        self.loadingScreen = true
        
        addPreRegPatient.preRegisterPatient(patientObj: preRegisteredPatient) { (patientId) in
            if (patientId != nil) {
                self.setAllergies(patientAllergies: self.allergies, patientId: patientId!)
                self.setFollowUp(nextFeeObj: self.followUpFeeObj, patientId: patientId!)
                DoctorDefaultModifiers.refreshAppointments()
                self.doctorAlertHelpers.patientAddedAlert()
                self.loadingScreen = false
                completion(true)
            } else {
                GlobalPopupHelpers.setErrorAlert()
            }
        }
    }
    
    func addPhoneNumberToPatientObj () {
        self.preRegisteredPatient.phoneNumber = phoneNumObj.countryCode + phoneNumObj.number.text
    }
    
    func setAllergies (patientAllergies:String, patientId:String) {
        PutPatientAllergiesViewModel().putPatientAllergiesForAppointment(patientAllergies: patientAllergies, patientId: patientId, appointmentId: "") { (_) in }
    }

    func setFollowUp(nextFeeObj:FollowUpAppointmentViewModel, patientId:String) {
        PutFollowUpAppointmentViewModel().makeFollowUpAppointment(followUpVM: nextFeeObj, patientId: patientId) { _ in }
    }

    func emptyValuesCheck() -> Bool {
        if preRegisteredPatient.age.isEmpty ||
            preRegisteredPatient.phoneNumber.isEmpty ||
            preRegisteredPatient.gender.isEmpty ||
            preRegisteredPatient.fullName.isEmpty {
            print("VALUES EMPTY")
            return false
        } else {
            print("VALUES NOT EMPTY")
            return true
        }
    }
}
