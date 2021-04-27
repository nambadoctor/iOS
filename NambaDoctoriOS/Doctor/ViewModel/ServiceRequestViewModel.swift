//
//  PrescriptionViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 22/01/21.
//

import Foundation
import SwiftUI


protocol LoadReportsWithServiceRequestDelegate {
    func gotServiceRequestId(serviceRequestId:String)
}

class ServiceRequestViewModel: ObservableObject {
    var appointment:ServiceProviderAppointment
    
    @Published var serviceRequest:ServiceProviderServiceRequest!
    
    @Published var errorInRetrievingPrescription:Bool = false
    @Published var navigateToReviewPrescription:Bool = false

    @Published var investigationsViewModel:InvestigationsViewModel = InvestigationsViewModel()
    
    var gotServiceRequestDelegate:LoadReportsWithServiceRequestDelegate? = nil
    
    private var retrieveServiceRequesthelper:ServiceProviderServiceRequestServiceProtocol
    private var docSheetHelper:DoctorSheetHelpers = DoctorSheetHelpers()
    private var docAlertHelper:DoctorAlertHelpers = DoctorAlertHelpers()
    
    var serviceRequestServiceCalls:ServiceProviderServiceRequestServiceProtocol

    init(appointment:ServiceProviderAppointment,
         retrieveServiceRequesthelper:ServiceProviderServiceRequestServiceProtocol = ServiceProviderServiceRequestService(),
         serviceRequestServiceCalls:ServiceProviderServiceRequestServiceProtocol = ServiceProviderServiceRequestService()) {
        
        self.appointment = appointment
        self.retrieveServiceRequesthelper = retrieveServiceRequesthelper
        self.serviceRequest = MakeEmptyServiceRequest(appointment: appointment)
        self.serviceRequestServiceCalls = serviceRequestServiceCalls
        
        self.retrieveServiceRequest()
    }

    var examination : String {
        return serviceRequest.examination.isEmpty ? "none" : "\(serviceRequest.examination)"
    }

    var diagnosisName : String {
        return serviceRequest.diagnosis.name.isEmpty ? "none" : "\(serviceRequest.diagnosis.name)"
    }
    
    var diagnosisType : String {
        return serviceRequest.diagnosis.type.isEmpty ? "" : "\(serviceRequest.diagnosis.type)"
    }

    var advice : String {
        return serviceRequest.advice.isEmpty ? "none" : "\(serviceRequest.advice)"
    }
    
    func retrieveServiceRequest() {
        retrieveServiceRequesthelper.getServiceRequest(appointmentId: self.appointment.appointmentID, serviceRequestId: appointment.serviceRequestID, customerId: self.appointment.customerID) { (serviceRequest) in
            if serviceRequest != nil {
                self.gotServiceRequestDelegate?.gotServiceRequestId(serviceRequestId: serviceRequest!.serviceRequestID)
                self.mapPrescriptionValues(serviceRequest: serviceRequest!)
                CommonDefaultModifiers.hideLoader()
            }
        }
    }

    func mapPrescriptionValues (serviceRequest:ServiceProviderServiceRequest) {
        self.serviceRequest = serviceRequest
        //need to optimize this in service. DO AFTER INITIAL LAUNCH!
        self.serviceRequest.customerID = appointment.customerID
        self.serviceRequest.appointmentID = appointment.appointmentID
        self.serviceRequest.serviceProviderID = appointment.serviceProviderID
        //end

        self.investigationsViewModel.investigations = serviceRequest.investigations
    }

    func sendToPatient (completion: @escaping (_ success:Bool,_ serviceRequestId:String?)->()) {
        print("ServiceRequest: \(serviceRequest)")
        investigationsViewModel.addTempIntoArrayWhenFinished()
        serviceRequest.investigations = investigationsViewModel.investigations
        serviceRequestServiceCalls.setServiceRequest(serviceRequest: serviceRequest) { (response) in
            if response != nil {
                completion(true, response)
            } else {
                completion(false, nil)
            }
        }
    }
}
