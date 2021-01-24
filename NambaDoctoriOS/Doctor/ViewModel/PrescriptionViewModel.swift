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
    let loggedInDoctor = LocalDecoder.decode(modelType: Doctor.self, from: LocalEncodingK.userObj.rawValue)!
    
    @Published var prescription:Prescription!
    @Published var errorInRetrievingPrescription:Bool = false
    @Published var navigateToReviewPrescription:Bool = false
    @Published var dismissAllViews:Bool = false
    
    @Published var MedicineVM:MedicineViewModel = MedicineViewModel()
    @Published var InvestigationsVM:InvestigationsViewModel = InvestigationsViewModel()
    @Published var FollowUpVM:FollowUpAppointmentViewModel = FollowUpAppointmentViewModel()
    @Published var MedicineEntryVM:MedicineEntryViewModel = MedicineEntryViewModel()
    @Published var patientAllergies:String = ""
    
    private var retrievePrescriptionHelper:RetrievePrescriptionForAppointmentProtocol
    private var retrieveFollowUpObjHelper:RetrieveFollowUpFeeObjProtocol
    private var retrieveAllergiesHelper:RetrievePatientAllergiesProtocol
    
    init(appointment:Appointment,
         isNewPrescription:Bool,
         retrievePrescriptionHelper:RetrievePrescriptionForAppointmentProtocol = RetrievePrescriptionForAppointmentViewModel(),
         
         retrieveFollowUpObjHelper:RetrieveFollowUpFeeObjProtocol = RetrieveFollowUpObjViewModel(),
         
         retrieveAllergiesHelper:RetrievePatientAllergiesProtocol = RetrievePatientAllergiesViewModel()) {

        self.appointment = appointment
        self.retrievePrescriptionHelper = retrievePrescriptionHelper
        self.retrieveFollowUpObjHelper = retrieveFollowUpObjHelper
        self.retrieveAllergiesHelper = retrieveAllergiesHelper

        if isNewPrescription {
            prescription = GetEmptyModelObj().getFreshPrescription()
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
        
        func mapPrescriptionValues (prescription:Prescription) {
            self.prescription = prescription
            self.MedicineVM.medicineArr = self.prescription.medicine ?? [Medicine]()
            self.InvestigationsVM.parsePlanIntoInvestigationsArr(planInfo: self.prescription.planInfo)
        }
        
        retrievePrescriptionHelper.getPrescription(appointmentId: self.appointment.id) { (prescription) in
            if prescription != nil {
                mapPrescriptionValues(prescription: prescription!)
            } else {
                //self.prescription = nil
                self.errorInRetrievingPrescription = true
            }
        }
    }

    func retrieveFollowUpFeeForPrescription() {
        retrieveFollowUpObjHelper.getNextFee(patientId: appointment.requestedBy) { (FollowUpObj) in
            if FollowUpObj != nil {
                self.FollowUpVM.mapExistingValuesFromFollowUpObj(followUpObj: FollowUpObj!)
            }
        }
    }

    func retrieveAllergiesForPatient() {
        retrieveAllergiesHelper.getPatientAllergies(patientId: appointment.requestedBy) { (allergies) in
            self.patientAllergies = allergies
        }
    }
    
    func sendToReviewPrescription() {
        InvestigationsVM.addTempIntoArrayWhenFinished()
        self.navigateToReviewPrescription = true
    }
}
