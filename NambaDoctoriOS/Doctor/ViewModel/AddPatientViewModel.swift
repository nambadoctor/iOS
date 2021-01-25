//
//  AddPatientViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 25/01/21.
//

import Foundation

class AddPatientViewModel: ObservableObject {
    @Published var preRegisteredPatient:PreRegisteredPatient
    @Published var followUpFeeObj:FollowUpAppointmentViewModel = FollowUpAppointmentViewModel()
    var addPreRegPatient = AddPreRegisteredViewModel()
    var doctorAlertHelpers = DoctorAlertHelpers()
    
    init() {
        preRegisteredPatient = PreRegisteredPatient()
    }
    
    func addPatient (completion: @escaping (_ added:Bool)->()) {
        guard emptyValuesCheck() else {
            GlobalPopupHelpers.fillAllFieldsAlert()
            //self.showLocalAlert.toggle()
            return
        }

        CommonDefaultModifiers.showLoader()
        
        addPreRegPatient.preRegisterPatient(patientObj: preRegisteredPatient, nextFeeObj: followUpFeeObj) { (success) in
            if success {
                DoctorDefaultModifiers.refreshAppointments()
                self.doctorAlertHelpers.patientAddedAlert()
                //self.showSheet.toggle()
            } else {
                GlobalPopupHelpers.setErrorAlert()
            }
        }
    }

    func emptyValuesCheck() -> Bool {
        return false
    }
}
