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

    var serviceRequest:ServiceProviderServiceRequest
    
    @Published var errorInRetrievingPrescription:Bool = false
    @Published var navigateToReviewPrescription:Bool = false
    @Published var dismissAllViews:Bool = false
    
    @Published var investigations:[String] = [String]()
    @Published var investigationTemp:String = ""
    

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
        self.investigations = serviceRequest.investigations
    }
    
    func removeInvestigationBySwiping(at offsets: IndexSet) {
        investigations.remove(atOffsets: offsets)
    }

    func removeInvestigationManually(index:Int) {
        self.investigations.remove(at: index)
    }
    
    func appendInvestigation() {
        guard !investigationTemp.isEmpty else {
            //show empty field alert locally
            return
        }

        addInvestigation()
    }
    
    func addTempIntoArrayWhenFinished () {
        if !investigationTemp.isEmpty {
            addInvestigation()
        }
    }
    
    func addInvestigation () {
        investigations.append(investigationTemp)
        investigationTemp = ""
    }

}
