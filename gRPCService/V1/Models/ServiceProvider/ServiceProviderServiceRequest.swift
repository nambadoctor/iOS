//
//  ServiceProviderServiceRequest.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 17/03/21.
//

import Foundation

struct ServiceProviderServiceRequest : Codable {
    var serviceRequestID:String
    var reason:String
    var serviceProviderID:String
    var appointmentID:String
    var examination:String
    var diagnosis:ServiceProviderDiagnosis
    var investigations:[String]
    var advice:String
    var createdDateTime:Int64
    var lastModifiedDate:Int64
    var customerID:String
    var allergy:ServiceProviderCustomerAllergy
    var medicalHistory:ServiceProviderCustomerMedicalHistory
    var childId:String
}
