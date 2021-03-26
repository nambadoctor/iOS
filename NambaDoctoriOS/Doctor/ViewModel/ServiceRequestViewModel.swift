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

    init(appointment:ServiceProviderAppointment,
         retrieveServiceRequesthelper:ServiceRequestGetSetCallProtocol = ServiceRequestGetSetCall()) {

        self.appointment = appointment
        self.retrieveServiceRequesthelper = retrieveServiceRequesthelper
        self.serviceRequest = MakeEmptyServiceRequest(appointment: appointment)
        
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
}
