//
//  CustomerAppointmentVerificationMessage.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 7/6/21.
//

import Foundation

struct CustomerAppointmentVerification {
    var AppointmentVerificationId:String
    var VerificationStatus:String
    var VerifiedBy:String
    var VerifiedTime:Int64?
    var CustomerResponseForReason:String
}
