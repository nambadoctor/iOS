//
//  CustomerAppointment.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/26/21.
//

import Foundation

struct CustomerAppointment {
    var appointmentID:String
    var serviceRequestID:String
    var parentAppointmentID:String
    var customerID:String
    var serviceProviderID:String
    var requestedBy:String
    var serviceProviderName:String
    var customerName:String
    var isBlockedByServiceProvider:Bool
    var status:String
    var serviceFee:Double
    var followUpDays:Int32
    var isPaid:Bool
    var scheduledAppointmentStartTime:Int64
    var scheduledAppointmentEndTime:Int64
    var actualAppointmentStartTime:Int64
    var actualAppointmentEndTime:Int64
    var createdDateTime:Int64
    var lastModifiedDate:Int64
    var noOfReports:Int32
    var cancellation:CustomerCancellation?
    var childId:String
    var paymentType:String
    var appointmentVerification:CustomerAppointmentVerification?
    var organisationId:String
    var organisationName:String
    var IsInPersonAppointment:Bool
    var AddressId:String
    var AppointmentTransfer:CustomerAppointmentTransfer?
}
