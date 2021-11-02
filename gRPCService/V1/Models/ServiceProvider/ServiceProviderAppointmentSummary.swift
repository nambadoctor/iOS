//
//  ServiceProviderAppointmentSummary.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 6/9/21.
//

import Foundation

struct ServiceProviderAppointmentSummary {
    var AppointmentId:String
    var PrescriptionImageByteString:String
    var PdfBytes:Data
    var ReportsList:[ServiceProviderReport]
    var AppointmentTime:Int64
    var AppointmentStatus:String
    var PrescriptionImagesUrl:[String]
    var ServiceRequest:ServiceProviderServiceRequest
    var Prescription:ServiceProviderPrescription
}
