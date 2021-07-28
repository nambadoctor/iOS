//
//  PrescriptionViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 22/01/21.
//

import Foundation
import SwiftUI


protocol LoadedServiceRequestDelegate {
    func gotServiceRequestId(serviceRequestId:String)
    func isForChild(childId:String)
}

class ServiceRequestViewModel: ObservableObject {
    var appointment:ServiceProviderAppointment
    
    @Published var serviceRequest:ServiceProviderServiceRequest!
    
    @Published var errorInRetrievingPrescription:Bool = false
    @Published var navigateToReviewPrescription:Bool = false
    
    @Published var isSmoker:String = "No"
    @Published var isAlcoholConsumer:String = "No"

    @Published var investigationsViewModel:InvestigationsViewModel = InvestigationsViewModel()
    
    var gotServiceRequestDelegate:LoadedServiceRequestDelegate? = nil
    
    private var docSheetHelper:DoctorSheetHelpers = DoctorSheetHelpers()
    private var docAlertHelper:DoctorAlertHelpers = DoctorAlertHelpers()
    
    var serviceRequestServiceCalls:ServiceProviderServiceRequestServiceProtocol

    init(appointment:ServiceProviderAppointment,
         serviceRequestServiceCalls:ServiceProviderServiceRequestServiceProtocol = ServiceProviderServiceRequestService()) {
        
        self.appointment = appointment
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
        serviceRequestServiceCalls.getServiceRequest(appointmentId: self.appointment.appointmentID, serviceRequestId: appointment.serviceRequestID, customerId: self.appointment.customerID) { (serviceRequest) in
            if serviceRequest != nil {
                self.gotServiceRequestDelegate?.gotServiceRequestId(serviceRequestId: serviceRequest!.serviceRequestID)
                self.mapPrescriptionValues(serviceRequest: serviceRequest!)
                
                if !serviceRequest!.childId.isEmpty {
                    self.gotServiceRequestDelegate?.isForChild(childId: serviceRequest!.childId)
                }
                
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

        self.isSmoker = "\(self.serviceRequest.customerVitals.IsSmoker)"
        self.isAlcoholConsumer = "\(self.serviceRequest.customerVitals.IsAlcoholConsumer)"
        
        if serviceRequest.customerVitals.IsSmoker {
            self.isSmoker = "Yes"
        } else {
            self.isSmoker = "No"
        }
        
        if serviceRequest.customerVitals.IsAlcoholConsumer {
            self.isAlcoholConsumer = "Yes"
        } else {
            self.isAlcoholConsumer = "No"
        }

        
        if serviceRequest.diagnosis.type.isEmpty {
            self.serviceRequest.diagnosis.type = "Provisional"
        }

        self.investigationsViewModel.investigations = serviceRequest.investigations
    }

    func sendToPatient (completion: @escaping (_ success:Bool,_ serviceRequestId:String?)->()) {
        investigationsViewModel.addTempIntoArrayWhenFinished()
        serviceRequest.investigations = investigationsViewModel.investigations
        
        if isSmoker == "No" {
            serviceRequest.customerVitals.IsSmoker = false
        } else {
            serviceRequest.customerVitals.IsSmoker = true
        }
        
        if isAlcoholConsumer == "No" {
            serviceRequest.customerVitals.IsAlcoholConsumer = false
        } else {
            serviceRequest.customerVitals.IsAlcoholConsumer = true
        }

        print("SERVICE REQUEST TO PRINT: \(serviceRequest)")
        serviceRequestServiceCalls.setServiceRequest(serviceRequest: serviceRequest) { (response) in
            if response != nil {
                completion(true, response)
            } else {
                completion(false, nil)
            }
        }
    }
}
