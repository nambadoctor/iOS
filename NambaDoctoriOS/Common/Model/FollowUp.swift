//
//  FollowUpObject.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 15/02/21.
//

import Foundation

struct FollowUp : Identifiable {
    internal init(id: String, patientID: String, doctorID: String, discountedFee: Int32, nofDays: Int32, createdDateTime: Int64, appointmentID: String) {
        self.id = id
        self.patientID = patientID
        self.doctorID = doctorID
        self.discountedFee = discountedFee
        self.nofDays = nofDays
        self.createdDateTime = createdDateTime
        self.appointmentID = appointmentID
    }
    
    var id:String
    var patientID:String
    var doctorID:String
    var discountedFee:Int32
    var nofDays:Int32
    var createdDateTime:Int64
    var appointmentID:String
}

func MakeEmptyFollowUp() -> FollowUp {
    return FollowUp(id: "", patientID: "", doctorID: "", discountedFee: 0, nofDays: 0, createdDateTime: 0, appointmentID: "")
}
