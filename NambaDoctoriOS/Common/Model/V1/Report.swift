//
//  Report.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 15/02/21.
//

import Foundation

struct Report : Identifiable {
    internal init(id: String, name: String, appointmentID: String, patientID: String, createdDateTime: Int64, fileType: String) {
        self.id = id
        self.name = name
        self.appointmentID = appointmentID
        self.patientID = patientID
        self.createdDateTime = createdDateTime
        self.fileType = fileType
    }
    
    var id:String
    var name:String
    var appointmentID:String
    var patientID:String
    var createdDateTime:Int64
    var fileType:String
}
