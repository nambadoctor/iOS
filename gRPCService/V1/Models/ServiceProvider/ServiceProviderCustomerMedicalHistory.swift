//
//  ServiceProviderCustomerMedicalHistory.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/8/21.
//

import Foundation

struct ServiceProviderCustomerMedicalHistory : Codable {
    var MedicalHistoryId:String
    var MedicalHistoryName:String
    var PastMedicalHistory:String
    var MedicationHistory:String
    var AppointmentId:String
    var ServiceRequestId:String
}
