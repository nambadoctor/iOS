//
//  Prescription.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 15/02/21.
//

import Foundation

struct Prescription : Identifiable {
    internal init(id: String, appointmentID: String, history: String, examination: String, diagnosis: String, diagnosisType: String, investigations: [String], advice: String, doctorID: String, patientID: String, createdDateTime: Int64, medicines: [Medicine]) {
        self.id = id
        self.appointmentID = appointmentID
        self.history = history
        self.examination = examination
        self.diagnosis = diagnosis
        self.diagnosisType = diagnosisType
        self.investigations = investigations
        self.advice = advice
        self.doctorID = doctorID
        self.patientID = patientID
        self.createdDateTime = createdDateTime
        self.medicines = medicines
    }

    var id:String
    var appointmentID:String
    var history:String
    var examination:String
    var diagnosis:String
    var diagnosisType:String
    var investigations:[String]
    var advice:String
    var doctorID:String
    var patientID:String
    var createdDateTime:Int64
    var medicines:[Medicine]
}

func MakeEmptyPrescription () -> Prescription {
    return Prescription(id: "", appointmentID: "", history: "", examination: "", diagnosis: "", diagnosisType: "", investigations: [""], advice: "", doctorID: "", patientID: "", createdDateTime: 0, medicines: [Medicine]())
}
