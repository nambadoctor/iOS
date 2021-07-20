//
//  ServiceProviderAppointmentVerification.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 7/20/21.
//

import Foundation

struct ServiceProviderAppointmentVerification : Codable {
    var AppointmentVerificationId:String
    var VerificationStatus:String
    var VerifiedBy:String
    var VerifiedTime:Int64?
    var CustomerResponseForReason:String
}
