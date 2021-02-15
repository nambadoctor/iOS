//
//  PatientObjMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 15/02/21.
//

import Foundation

class PatientObjMapper {
    func grpcToLocalPatientObject(patient:Nambadoctor_V1_PatientObject) -> Patient {
        let patient = Patient(patientID: patient.patientID,
                              age: patient.age,
                              deviceTokenID: patient.deviceTokenID,
                              fullName: patient.fullName,
                              language: patient.language,
                              phoneNumber: patient.phoneNumber,
                              preferredDoctorID: patient.preferredDoctorID,
                              createdDateTime: patient.createdDateTime,
                              gender: patient.gender)
        
        return patient
    }
    
    func localPatientToGrpcObject(patient:Patient) -> Nambadoctor_V1_PatientObject {
        let patient = Nambadoctor_V1_PatientObject.with {
            $0.patientID = patient.patientID
            $0.age = patient.age
            $0.deviceTokenID = patient.deviceTokenID
            $0.fullName = patient.fullName
            $0.language = patient.language
            $0.phoneNumber = patient.phoneNumber
            $0.preferredDoctorID = patient.preferredDoctorID
            $0.createdDateTime = patient.createdDateTime
            $0.gender = patient.gender
        }  
        
        return patient
    }
}
