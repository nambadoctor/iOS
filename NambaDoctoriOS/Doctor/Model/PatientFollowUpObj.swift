//
//  NextFeeObj.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 23/01/21.
//

import Foundation

struct PatientFollowUpObj : Identifiable, Codable {
    internal init(id: String? = UUID().uuidString, PatientId: String, appointmentId: String, createdDateTime: String, doctorId: String, nextAppointmentFee: Int, validityDays: Int) {
        self.id = id
        self.PatientId = PatientId
        self.appointmentId = appointmentId
        self.createdDateTime = createdDateTime
        self.doctorId = doctorId
        self.nextAppointmentFee = nextAppointmentFee
        self.validityDays = validityDays
    }

    var id:String? = UUID().uuidString
    var PatientId:String
    var appointmentId:String
    var createdDateTime:String
    var doctorId:String
    var nextAppointmentFee:Int
    var validityDays:Int
}
