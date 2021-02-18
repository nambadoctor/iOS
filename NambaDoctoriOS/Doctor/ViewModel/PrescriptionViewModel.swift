//
//  PrescriptionViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 22/01/21.
//

import Foundation
import SwiftUI

class PrescriptionViewModel: ObservableObject {
    var appointment:Appointment
    var isNewPrescription:Bool
    var loggedInDoctor:Doctor
    
    @Published var prescription:Prescription!
    @Published var errorInRetrievingPrescription:Bool = false
    @Published var navigateToReviewPrescription:Bool = false
    @Published var dismissAllViews:Bool = false
    
    @Published var MedicineVM:MedicineViewModel = MedicineViewModel()
    @Published var InvestigationsVM:InvestigationsViewModel = InvestigationsViewModel()
    @Published var FollowUpVM:FollowUpAppointmentViewModel = FollowUpAppointmentViewModel()
    @Published var MedicineEntryVM:MedicineEntryViewModel = MedicineEntryViewModel()
    @Published var patientAllergies:String = ""
    
    private var docObjectHelper:GetDocObjectProtocol
    private var retrievePrescriptionHelper:RetrievePrescriptionForAppointmentProtocol
    private var retrieveFollowUpObjHelper:RetrieveFollowUpFeeObjProtocol
    private var retrieveAllergiesHelper:RetrievePatientAllergiesProtocol
    
    private var docSheetHelper:DoctorSheetHelpers = DoctorSheetHelpers()
    private var docAlertHelper:DoctorAlertHelpers = DoctorAlertHelpers()
    
    init(appointment:Appointment,
         isNewPrescription:Bool,
         docObjectHelper:GetDocObjectProtocol = GetDocObject(),
         retrievePrescriptionHelper:RetrievePrescriptionForAppointmentProtocol = RetrievePrescriptionForAppointmentViewModel(),
         retrieveFollowUpObjHelper:RetrieveFollowUpFeeObjProtocol = RetrieveFollowUpObjViewModel(),
         retrieveAllergiesHelper:RetrievePatientAllergiesProtocol = RetrievePatientAllergiesViewModel()) {
        
        self.appointment = appointment
        self.isNewPrescription = isNewPrescription
        self.retrievePrescriptionHelper = retrievePrescriptionHelper
        self.retrieveFollowUpObjHelper = retrieveFollowUpObjHelper
        self.retrieveAllergiesHelper = retrieveAllergiesHelper
        self.docObjectHelper = docObjectHelper
        self.loggedInDoctor = docObjectHelper.getDoctor()
    }
    
    /*
     not called as part of init.
     if its part of init, it will run Get calls for prescription and allergy for every instance
     this way, only when the write or view prescription view is opened, the values are retrieved
     */
    func prescriptionViewOnAppear () {
        
        guard self.checkIfPrescriptionIsEmpty() else { return }
        print("PASSING")
        if isNewPrescription { //entry from upcoming appointments
            checkForStoredPrescriptionAndRetreive()
        } else {
            self.retrievePrescription()
        }
        
        retrieveAllergiesForPatient()
    }
    
    var hasMedicines:Bool {
        if MedicineVM.medicineArr.isEmpty {
            return false
        } else {
            return true
        }
    }
    
    func retrievePrescription() {
        retrievePrescriptionHelper.getPrescription(appointmentId: self.appointment.appointmentID) { (prescription) in
            if prescription != nil {
                self.mapPrescriptionValues(prescription: prescription!)
            } else {
                //self.prescription = nil
                self.errorInRetrievingPrescription = true
            }
        }
    }

    func mapPrescriptionValues (prescription:Prescription) {
        self.prescription = prescription
        self.MedicineVM.medicineArr = self.prescription.medicines
        self.InvestigationsVM.parsePlanIntoInvestigationsArr(planInfo: self.prescription.advice)
    }

    func retrieveFollowUpFeeForPrescription() {
        retrieveFollowUpObjHelper.getNextFee(doctorId: loggedInDoctor.doctorID, patientId: appointment.requestedBy) { (FollowUpObj) in
            if FollowUpObj != nil {
                self.FollowUpVM.mapExistingValuesFromFollowUpObj(followUpObj: FollowUpObj!)
            }
        }
    }

    func retrieveAllergiesForPatient() {
        retrieveAllergiesHelper.getPatientAllergies(patientId: appointment.requestedBy) { (allergies) in
            self.patientAllergies = allergies ?? "none"
        }
    }

    func sendToReviewPrescription() {
        InvestigationsVM.addTempIntoArrayWhenFinished()
        self.navigateToReviewPrescription = true
    }

    func viewPatientInfo() {
        docSheetHelper.showPatientInfoSheet(appointment: appointment)
    }

    func checkIfPrescriptionIsEmpty () -> Bool {
        if prescription == nil {
            return true
        } else if prescription.history.isEmpty || prescription.diagnosis.isEmpty || prescription.examination.isEmpty {
            return true
        } else {
            return false
        }
    }

    func checkForStoredPrescriptionAndRetreive() {
        let storedPrescription = LocalDecoder.decode(modelType: Prescription.self, from: "prescription:\(self.appointment.appointmentID)")

        if storedPrescription == nil {
            self.prescription = MakeEmptyPrescription()
            self.prescription.appointmentID = appointment.appointmentID
        } else {
            self.mapPrescriptionValues(prescription: storedPrescription!)
        }
    }

    func navBarBackPressed (completion: @escaping (_ GoBack:Bool)->()) {
        func encodePrescriptionLocally () {
            self.prescription.advice = self.InvestigationsVM.investigations.joined(separator: ";")

            self.prescription.medicines = self.MedicineVM.medicineArr

            LocalEncoder.encode(payload: self.prescription, destination: "prescription:\(self.appointment.appointmentID)")
        }

        func deleteLocallyStoredPrescription () {
            LocalEncoder.encode(payload: MakeEmptyPrescription(), destination: "prescription:\(self.appointment.appointmentID)")
        }

        docAlertHelper.askToSavePrescriptionAlert() { save in
            if save {
                encodePrescriptionLocally()
                completion(true)
            } else {
                deleteLocallyStoredPrescription()
                completion(false)
            }
        }
    }
}
