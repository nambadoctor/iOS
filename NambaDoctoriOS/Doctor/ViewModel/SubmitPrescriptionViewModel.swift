//
//  SubmitPrescriptionViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 23/01/21.
//

import Foundation

class SubmitPrescriptionViewModel: ObservableObject {
    var prescriptionVM:ServiceRequestViewModel
    
    var putPrescriptionVM:PrescriptionGetSetServiceCallProtocol
    var updateAptStatusVM:UpdateAppointmentStatusProtocol
    var docAlertHelpers:DoctorAlertHelpersProtocol
    
    init(prescriptionVM:ServiceRequestViewModel,
         putPrescriptionVM:PrescriptionGetSetServiceCallProtocol = PrescriptionGetSetServiceCall(),
         updateAptStatusVM:UpdateAppointmentStatusProtocol = UpdateAppointmentStatusHelper(),
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
        putPrescription()
        updateAptSatus()
    }
    
    private func putPrescription () {
        
        func toggleToTrue () {
            self.prescriptionDone = true
            RemoveStoredObject.removeForKey(key: "stored_prescriptions")
            checkIfAllWritesDone()
        }

        putPrescriptionVM.setPrescription(medicineViewModel: prescriptionVM.MedicineVM) { (success) in
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
