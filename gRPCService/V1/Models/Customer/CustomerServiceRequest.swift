//
//  CustomerServiceRequest.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/26/21.
//

import Foundation

struct CustomerServiceRequest {
    var serviceRequestID:String
    var reason:String
    var serviceProviderID:String
    var appointmentID:String
    var examination:String
    var diagnosis:CustomerDiagnosis
    var investigations:[String]
    var advice:String
    var createdDateTime:Int64
    var lastModifiedDate:Int64
    var customerID:String
    var allergy:CustomerAllergy
    var medicalHistory:CustomerMedicalHistory
}
