//
//  AddPatientViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 25/01/21.
//

import Foundation

class AddPatientViewModel: ObservableObject {
    @Published var preRegisteredPatient:Nambadoctor_V1_PatientObject
    @Published var followUpFeeObj:FollowUpAppointmentViewModel = FollowUpAppointmentViewModel()
    var allergies:String = ""
    var addPreRegPatient = AddPreRegisteredViewModel()
    var doctorAlertHelpers = DoctorAlertHelpers()

    init() {
        preRegisteredPatient = Nambadoctor_V1_PatientObject()
    }
    
    func addPatient (completion: @escaping (_ added:Bool)->()) {
        guard emptyValuesCheck() else {
            GlobalPopupHelpers.fillAllFieldsAlert()
            //self.showLocalAlert.toggle()
            return
        }

        CommonDefaultModifiers.showLoader()
        
        addPreRegPatient.preRegisterPatient(patientObj: preRegisteredPatient) { (patientId) in
            if (patientId != nil) {
                self.setAllergies(patientAllergies: self.allergies, patientId: patientId!)
                self.setFollowUp(nextFeeObj: self.followUpFeeObj, patientId: patientId!)
                DoctorDefaultModifiers.refreshAppointments()
                self.doctorAlertHelpers.patientAddedAlert()
                completion(true)
            } else {
                GlobalPopupHelpers.setErrorAlert()
            }
        }
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
            return false
        } else {
            return true
        }
    }
}
