//
//  PrescriptionViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 22/01/21.
//

import Foundation
import SwiftUI

class ServiceRequestViewModel: ObservableObject {
    var appointment:ServiceProviderAppointment
    var isNewPrescription:Bool
    var loggedInDoctor:ServiceProviderProfile = serviceProvider!

    @Published var serviceRequest:ServiceProviderServiceRequest!
    @Published var errorInRetrievingPrescription:Bool = false
    @Published var navigateToReviewPrescription:Bool = false
    @Published var dismissAllViews:Bool = false

    @Published var MedicineVM:MedicineViewModel = MedicineViewModel()
    @Published var InvestigationsVM:InvestigationsViewModel = InvestigationsViewModel()
    @Published var FollowUpVM:FollowUpAppointmentViewModel = FollowUpAppointmentViewModel()
    @Published var MedicineEntryVM:MedicineEntryViewModel = MedicineEntryViewModel()
    @Published var patientAllergies:String = ""

    private var retrieveServiceRequesthelper:RetrieveServiceRequestProtocol
    private var docSheetHelper:DoctorSheetHelpers = DoctorSheetHelpers()
    private var docAlertHelper:DoctorAlertHelpers = DoctorAlertHelpers()
    
    init(appointment:ServiceProviderAppointment,
         isNewPrescription:Bool,
         retrieveServiceRequesthelper:RetrieveServiceRequestProtocol = RetrieveServiceRequestViewModel()) {
        
        self.appointment = appointment
        self.isNewPrescription = isNewPrescription
        self.retrieveServiceRequesthelper = retrieveServiceRequesthelper
    }
    
    /*
     not called as part of init.
     if its part of init, it will run Get calls for prescription and allergy for every instance
     this way, only when the write or view prescription view is opened, the values are retrieved
     */
    func prescriptionViewOnAppear () {
        DispatchQueue.main.async {
            guard self.checkIfPrescriptionIsEmpty() else { return }
            if self.isNewPrescription { //entry from upcoming appointments
                self.checkForStoredPrescriptionAndRetreive()
            } else {
                self.retrievePrescription()
            }
        }
    }

    var hasMedicines:Bool {
        if MedicineVM.medicineArr.isEmpty {
            return false
        } else {
            return true
        }
    }
    
    func retrievePrescription() {
        retrieveServiceRequesthelper.getServiceRequest(appointmentId: self.appointment.appointmentID, serviceRequestId: appointment.serviceRequestID, customerId: self.appointment.customerID) { (serviceRequest) in
            if serviceRequest != nil {
                self.mapPrescriptionValues(serviceRequest: serviceRequest!)
            } else {
                //self.prescription = nil
                self.errorInRetrievingPrescription = true
            }
        }
    }

    func mapPrescriptionValues (serviceRequest:ServiceProviderServiceRequest) {
        self.serviceRequest = serviceRequest
        self.InvestigationsVM.parsePlanIntoInvestigationsArr(planInfo: self.serviceRequest.advice)
    }

    func sendToReviewPrescription() {
        InvestigationsVM.addTempIntoArrayWhenFinished()
        self.serviceRequest.investigations = InvestigationsVM.investigations

        self.navigateToReviewPrescription = true
    }

    func viewPatientInfo() {
        docSheetHelper.showPatientInfoSheet(appointment: appointment)
    }

    func checkIfPrescriptionIsEmpty () -> Bool {
        if serviceRequest == nil {
            return true
        } else if serviceRequest.diagnosis.name.isEmpty || serviceRequest.examination.isEmpty {
            return true
        } else {
            return false
        }
    }

    func checkForStoredPrescriptionAndRetreive() {
        let storedPrescription:ServiceProviderServiceRequest? = LocalDecoder.decode(modelType: ServiceProviderServiceRequest.self, from: "stored_prescriptions:\(self.appointment.appointmentID)")

        if storedPrescription == nil {
            self.prescription = MakeEmptyPrescription()
            self.serviceRequest.appointmentID = appointment.appointmentID
            self.serviceRequest.serviceProviderID = loggedInDoctor.serviceProviderID
            self.serviceRequest.customerID = appointment.customerID
        } else {
            self.mapPrescriptionValues(serviceRequest: storedPrescription!)
        }
    }

    func navBarBackPressed (completion: @escaping (_ GoBack:Bool)->()) {
        func encodePrescriptionLocally () {
            self.serviceRequest.advice = self.InvestigationsVM.investigations.joined(separator: ";")

            LocalEncoder.encode(payload: self.serviceRequest, destination: "stored_prescriptions:\(self.appointment.appointmentID)")
        }

        func deleteLocallyStoredPrescription () {
            LocalEncoder.encode(payload: MakeEmptyPrescription(), destination: "stored_prescriptions:\(self.appointment.appointmentID)")
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
