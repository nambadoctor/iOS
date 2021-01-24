//
//  PutPatientAllergies.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 23/01/21.
//

import Foundation

class PutPatientAllergiesViewModel: PutPatientAllergiesProtocol {
    func putPatientAllergiesForAppointment (prescriptionVM:PrescriptionViewModel, _ completion : @escaping ((_ successfull:Bool)->())) {
        let parameters: [String: Any] = [
            "allergies": prescriptionVM.patientAllergies,
            "patientId": prescriptionVM.appointment.requestedBy
        ]
        ApiPutCall.put(parameters: parameters, extensionURL: "appointment/allergy/\(prescriptionVM.appointment.id)") { (success, data) in
            print("ALLERGIES \(success)")
            completion(success)
        }
    }

//    func updatePatientAllergies (prescriptionVM:PrescriptionViewModel, _ completion : @escaping ((_ successfull:Bool)->())) {
//        let parameters: [String: Any] = [
//            "allergies": prescriptionVM.patientAllergies,
//            "patientId": prescriptionVM.appointment.requestedBy
//        ]
//        ApiPutCall.put(parameters: parameters, extensionURL: "appointment/allergy/\(prescriptionVM.appointment.id)") { (success, data) in
//            completion(success)
//        }
//    }
}
