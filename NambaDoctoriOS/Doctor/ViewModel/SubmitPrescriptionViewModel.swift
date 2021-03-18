//
//  SubmitPrescriptionViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 23/01/21.
//

import Foundation

class SubmitPrescriptionViewModel: ObservableObject {
    var prescriptionVM:ServiceRequestViewModel
    
    var putPrescriptionVM:PutPrescriptionViewModelProtocol
    var updateAptStatusVM:UpdateAppointmentStatusProtocol
    var docAlertHelpers:DoctorAlertHelpersProtocol
    
    init(prescriptionVM:ServiceRequestViewModel,
         putPrescriptionVM:PutPrescriptionViewModelProtocol = PutPrescriptionViewModel(),
         updateAptStatusVM:UpdateAppointmentStatusProtocol = UpdateAppointmentStatusViewModel(),
         docAlertHelpers:DoctorAlertHelpersProtocol = DoctorAlertHelpers()) {
        
        self.prescriptionVM = prescriptionVM
        self.putPrescriptionVM = putPrescriptionVM
        self.updateAptStatusVM = updateAptStatusVM
        self.docAlertHelpers = docAlertHelpers
    }
    
    var prescriptionDone:Bool = false
    var followUpDone:Bool = false
    var allergiesDone:Bool = false
    var updateStatusDone:Bool = false

    func submitPrescription () {
        prescriptionVM.prescription.medicines = prescriptionVM.MedicineVM.medicineArr

        putPrescription()
        putFollowUp()
        putAllergies()
        updateAptSatus()
    }
    
    private func putPrescription () {
        
        func toggleToTrue () {
            self.prescriptionDone = true
            RemoveStoredObject.removeForKey(key: "stored_prescriptions")
            checkIfAllWritesDone()
        }

        putPrescriptionVM.writePrescriptionToDB(prescriptionViewModel: prescriptionVM) { (success) in
            if success {
                toggleToTrue()
            } else {
                GlobalPopupHelpers.setErrorAlert()
            }
        }
    }
    
    private func putFollowUp () {
        
        func toggleToTrue () {
            self.followUpDone = true
            checkIfAllWritesDone()
        }
        
        guard prescriptionVM.FollowUpVM.needFollowUp else {
            toggleToTrue()
            return
        }
        putFollowUpVM.makeFollowUpAppointment(prescriptionVM: prescriptionVM) { (success) in
            if success {
                toggleToTrue()
            } else {
                GlobalPopupHelpers.setErrorAlert()
            }
        }
    }

    private func putAllergies () {
        
        func toggleToTrue () {
            self.allergiesDone = true
            checkIfAllWritesDone()
        }
        
        guard prescriptionVM.patientAllergies != "none" else {
            toggleToTrue()
            return
        }
        
        putAllergiesVM.putPatientAllergiesForAppointment(prescriptionVM: prescriptionVM) { (success) in
            if success {
                toggleToTrue()
            } else {
                GlobalPopupHelpers.setErrorAlert()
            }
        }
    }
    
    private func updateAptSatus() {
        
        func toggleToTrue () {
            self.updateStatusDone = true
            checkIfAllWritesDone()
        }
        
        updateAptStatusVM.updateToFinished(appointment: &prescriptionVM.appointment) { (success) in
            if success {
                toggleToTrue()
            } else {
                GlobalPopupHelpers.setErrorAlert()
            }
        }
    }
    
    private func checkIfAllWritesDone() {
        if prescriptionDone && followUpDone && allergiesDone && updateStatusDone {
            DoctorDefaultModifiers.refreshAppointments()
            prescriptionVM.dismissAllViews = true
        }
    }
}
