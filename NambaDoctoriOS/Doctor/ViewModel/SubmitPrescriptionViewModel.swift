//
//  SubmitPrescriptionViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 23/01/21.
//

import Foundation

class SubmitPrescriptionViewModel: ObservableObject {
    @Published var prescriptionVM:PrescriptionViewModel
    
    var putPrescriptionVM:PutPrescriptionViewModelProtocol
    var putFollowUpVM:PutFollowUpAppointmentViewModelProtocol
    var putAllergiesVM:PutPatientAllergiesProtocol
    var updateAptStatusVM:UpdateAppointmentStatusProtocol
    
    init(prescriptionVM:PrescriptionViewModel,
         putPrescriptionVM:PutPrescriptionViewModelProtocol = PutPrescriptionViewModel(),
         putFollowUpVM:PutFollowUpAppointmentViewModelProtocol = PutFollowUpAppointmentViewModel(),
         putAllergiesVM:PutPatientAllergiesProtocol = PutPatientAllergiesViewModel(),
         updateAptStatusVM:UpdateAppointmentStatusProtocol = UpdateAppointmentStatusViewModel()) {
        
        self.prescriptionVM = prescriptionVM
        self.putPrescriptionVM = putPrescriptionVM
        self.putFollowUpVM = putFollowUpVM
        self.putAllergiesVM = putAllergiesVM
        self.updateAptStatusVM = updateAptStatusVM
    }
    
    var prescriptionDone:Bool = false
    var followUpDone:Bool = false
    var allergiesDone:Bool = false
    var updateStatusDone:Bool = false

    func submitPrescription () {
        prescriptionVM.prescription.planInfo = prescriptionVM.InvestigationsVM.investigations.joined(separator: ";")

        prescriptionVM.prescription.medicine = prescriptionVM.MedicineVM.medicineArr

        putPrescription()
        putFollowUp()
        putAllergies()
        updateAptSatus()
    }
    
    private func putPrescription () {
        
        func toggleToTrue () {
            self.prescriptionDone = true
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
        
        updateAptStatusVM.updateToFinished(appointmentId: prescriptionVM.appointment.id) { (success) in
            if success {
                toggleToTrue()
            } else {
                GlobalPopupHelpers.setErrorAlert()
            }
        }
    }
    
    private func checkIfAllWritesDone() {
        if prescriptionDone && followUpDone && allergiesDone && updateStatusDone {
            prescriptionVM.dismissAllViews = true
        }
    }
}
