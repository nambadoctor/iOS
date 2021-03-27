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
    
    @Published var serviceRequest:ServiceProviderServiceRequest
    
    @Published var errorInRetrievingPrescription:Bool = false
    @Published var navigateToReviewPrescription:Bool = false
    @Published var dismissAllViews:Bool = false
    
    @Published var investigationsViewModel:InvestigationsViewModel = InvestigationsViewModel()
    
    private var retrieveServiceRequesthelper:ServiceRequestGetSetCallProtocol
    private var docSheetHelper:DoctorSheetHelpers = DoctorSheetHelpers()
    private var docAlertHelper:DoctorAlertHelpers = DoctorAlertHelpers()
    
    var serviceRequestServiceCalls:ServiceRequestGetSetCallProtocol
    
    init(appointment:ServiceProviderAppointment,
         retrieveServiceRequesthelper:ServiceRequestGetSetCallProtocol = ServiceRequestGetSetCall(),
         serviceRequestServiceCalls:ServiceRequestGetSetCallProtocol = ServiceRequestGetSetCall()) {
        
        self.appointment = appointment
        self.retrieveServiceRequesthelper = retrieveServiceRequesthelper
        self.serviceRequest = MakeEmptyServiceRequest(appointment: appointment)
        self.serviceRequestServiceCalls = serviceRequestServiceCalls
        
        DispatchQueue.main.async {
            self.retrieveServiceRequest()
        }
    }
    
    func retrieveServiceRequest() {
        retrieveServiceRequesthelper.getServiceRequest(appointmentId: self.appointment.appointmentID, serviceRequestId: appointment.serviceRequestID, customerId: self.appointment.customerID) { (serviceRequest) in
            if serviceRequest != nil {
                self.mapPrescriptionValues(serviceRequest: serviceRequest!)
            }
        }
    }
    
    func mapPrescriptionValues (serviceRequest:ServiceProviderServiceRequest) {
        self.serviceRequest = serviceRequest
        self.investigationsViewModel.investigations = serviceRequest.investigations
    }
    
    func sendToPatient (completion: @escaping (_ success:Bool)->()) {
        print("ServiceRequest: \(serviceRequest)")
        serviceRequestServiceCalls.setServiceRequest(serviceRequest: serviceRequest) { (response) in
            if response != nil {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}
