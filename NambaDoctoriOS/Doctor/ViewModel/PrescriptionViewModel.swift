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
    let loggedInDoctor = getLoggedInDoctor()
    
    @Published var prescription:Nambadoctor_V1_PrescriptionObject!
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
    
    private var docSheetHelper:DoctorSheetHelpers = DoctorSheetHelpers()
    private var docAlertHelper:DoctorAlertHelpers = DoctorAlertHelpers()

    init(appointment:Appointment,
         isNewPrescription:Bool,
         retrievePrescriptionHelper:RetrievePrescriptionForAppointmentProtocol = RetrievePrescriptionForAppointmentViewModel(),

         retrieveFollowUpObjHelper:RetrieveFollowUpFeeObjProtocol = RetrieveFollowUpObjViewModel(),

         retrieveAllergiesHelper:RetrievePatientAllergiesProtocol = RetrievePatientAllergiesViewModel()) {

        self.appointment = appointment
        self.isNewPrescription = isNewPrescription
        self.retrievePrescriptionHelper = retrievePrescriptionHelper
        self.retrieveFollowUpObjHelper = retrieveFollowUpObjHelper
        self.retrieveAllergiesHelper = retrieveAllergiesHelper
    }

    /*
     not called as part of init.
     if its part of init, it will run Get calls for prescription and allergy for every instance
     this way, only when the write or view prescription view is opened, the values are retrieved
     */
    func prescriptionViewOnAppear () {
        if isNewPrescription { //entry from upcoming appointments
            //checkForStoredPrescriptionAndRetreive()
            self.retrievePrescription()
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
    
//    func checkForStoredPrescriptionAndRetreive() {
//        let storedPrescription = LocalDecoder.decode(modelType: Nambadoctor_V1_PrescriptionObject.self, from: "prescription:\(self.appointment.id)")
//
//        if storedPrescription == nil {
//            self.prescription = Nambadoctor_V1_PrescriptionObject()
//        } else {
//            self.mapPrescriptionValues(prescription: storedPrescription!)
//        }
//    }

    func retrievePrescription() {
        retrievePrescriptionHelper.getPrescription(appointmentId: self.appointment.id) { (prescription) in
            if prescription != nil {
                self.mapPrescriptionValues(prescription: prescription!)
            } else {
                //self.prescription = nil
                self.errorInRetrievingPrescription = true
            }
        }
    }
    
    func mapPrescriptionValues (prescription:Nambadoctor_V1_PrescriptionObject) {
        self.prescription = prescription
        self.MedicineVM.medicineArr = self.prescription.medicines
        self.InvestigationsVM.parsePlanIntoInvestigationsArr(planInfo: self.prescription.advice)
    }

    func retrieveFollowUpFeeForPrescription() {
        retrieveFollowUpObjHelper.getNextFee(doctorId: loggedInDoctor.id, patientId: appointment.requestedBy) { (FollowUpObj) in
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

    func viewPatientInfo() {
        docSheetHelper.showPatientInfoSheet(appointment: appointment)
    }
    
    func navBarBackPressed (completion: @escaping (_ GoBack:Bool)->()) {
        
//        func encodePrescriptionLocally () {
//            self.prescription.advice = self.InvestigationsVM.investigations.joined(separator: ";")
//
//            self.prescription.medicines = self.MedicineVM.medicineArr
//        }
//
//        docAlertHelper.askToSavePrescriptionAlert() { save in
//            if save {
//                encodePrescriptionLocally()
//                completion(true)
//            } else {
//                completion(true)
//            }
//        }
        
        completion(true)
    }
}
