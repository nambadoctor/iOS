//
//  Appointment.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 15/02/21.
//

import Foundation

struct Appointment : Identifiable{
    internal init(id: String = UUID().uuidString, appointmentID: String, preferredLanguage: String, status: String, doctorID: String, doctorName: String, requestedBy: String, patientName: String, consultationFee: Int32, paymentStatus: String, problemDetails: String, createdDateTime: Int64, slotID: String, discountedConsultationFee: Int32, requestedTime: Int64, noOfReports: Int32) {
        self.id = id
        self.appointmentID = appointmentID
        self.preferredLanguage = preferredLanguage
        self.status = status
        self.doctorID = doctorID
        self.doctorName = doctorName
        self.requestedBy = requestedBy
        self.patientName = patientName
        self.consultationFee = consultationFee
        self.paymentStatus = paymentStatus
        self.problemDetails = problemDetails
        self.createdDateTime = createdDateTime
        self.slotID = slotID
        self.discountedConsultationFee = discountedConsultationFee
        self.requestedTime = requestedTime
        self.noOfReports = noOfReports
    }
    
    var id = UUID().uuidString
    var appointmentID:String
    var preferredLanguage:String
    var status:String
    var doctorID:String
    var doctorName:String
    var requestedBy:String
    var patientName:String
    var consultationFee:Int32
    var paymentStatus:String
    var problemDetails:String
    var createdDateTime:Int64
    var slotID:String
    var discountedConsultationFee:Int32
    var requestedTime:Int64
    var noOfReports:Int32
}

func MakeEmptyAppointment() -> Appointment {
    return Appointment(appointmentID: "", preferredLanguage: "", status: "", doctorID: "", doctorName: "", requestedBy: "", patientName: "", consultationFee: 0, paymentStatus: "", problemDetails: "", createdDateTime: Date().millisecondsSince1970, slotID: "", discountedConsultationFee: 0, requestedTime: Date().millisecondsSince1970, noOfReports: 0)
}
