//
//  PreRegPatientObjMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 20/02/21.
//

import Foundation

class PreRegPatientObjectMapper {
    func grpcToLocalPreRegPatientObject(patient:Nambadoctor_V1_PreRegPatientObject) -> PreRegPatient {
        let localPatient = PreRegPatient(age: patient.age,
                                         fullName: patient.fullName,
                                         phoneNumber: patient.phoneNumber,
                                         preferredDoctorID: patient.preferredDoctorID,
                                         createdDateTime: patient.createdDateTime,
                                         gender: patient.gender)
        return localPatient
    }
    
    func localPreRegPatientToGrpcObject(patient:PreRegPatient) -> Nambadoctor_V1_PreRegPatientObject {
        let localPatient = Nambadoctor_V1_PreRegPatientObject.with {
            $0.age = patient.age
            $0.fullName = patient.fullName
            $0.phoneNumber = patient.phoneNumber
            $0.preferredDoctorID = patient.preferredDoctorID
            $0.createdDateTime = patient.createdDateTime
            $0.gender = patient.gender
        }
        
        return localPatient
    }
    
}
