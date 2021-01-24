//
//  Prescription.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 22/01/21.
//

import Foundation

class Prescription: Codable, Identifiable {
    internal init(additionalNotes: String, appointmentId: String, clinicalSummary: String, diagnosis: String, diagnosisType: String, doctorId: String, history: String, medicine: [Medicine]? = nil, planInfo: String, referals: String) {
        self.additionalNotes = additionalNotes
        self.appointmentId = appointmentId
        self.clinicalSummary = clinicalSummary
        self.diagnosis = diagnosis
        self.diagnosisType = diagnosisType
        self.doctorId = doctorId
        self.history = history
        self.medicine = medicine
        self.planInfo = planInfo
        self.referals = referals
    }
    
    var additionalNotes:String
    var appointmentId:String
    var clinicalSummary:String
    var diagnosis:String
    var diagnosisType:String
    var doctorId:String
    var history:String
    var medicine:[Medicine]?
    var planInfo:String
    var referals:String
}
