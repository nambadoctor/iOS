//
//  RetrievePrescriptionForAppointment.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 22/01/21.
//

import Foundation

class RetrievePrescriptionForAppointmentViewModel : RetrievePrescriptionForAppointmentProtocol {
    func getPrescription (appointmentId:String, _ completion: @escaping ((_ prescription:Prescription?)->())) {
        
        ApiGetCall.get(extensionURL: "prescription/appointment/\(appointmentId)") { (data) in
            do {
                let prescription = try JSONDecoder().decode(Prescription.self, from: data)
                completion(prescription)
            } catch {
                completion(nil)
                print(error)
            }
        }
        
    }
}
