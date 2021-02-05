//
//  PutPatientAllergies.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 23/01/21.
//

import Foundation

class PutPatientAllergiesViewModel: PutPatientAllergiesProtocol {
    func putPatientAllergiesForAppointment (prescriptionVM:PrescriptionViewModel, _ completion : @escaping ((_ successfull:Bool)->())) {
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let allergiestClient = Nambadoctor_V1_AllergyWorkerv1Client(channel: channel)
        
        let request = makeAllergyObj(allergies: prescriptionVM.patientAllergies,
                                     patientId: prescriptionVM.appointment.requestedBy,
                                     appointmentId: prescriptionVM.appointment.appointmentID)
        
        let putAllergy = allergiestClient.saveNewAllergy(request)
        
        do {
            let response = try putAllergy.response.wait()
            completion(true)
            print("Allergies Put Client Successful: \(response.allergyID)")
        } catch {
            print("Allergies Put Client Failure")
        }

    }

    func putPatientAllergiesForAppointment (patientAllergies:String,
                                            patientId:String,
                                            appointmentId:String,
                                            _ completion : @escaping ((_ successfull:Bool)->())) {
        
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let allergiestClient = Nambadoctor_V1_AllergyWorkerv1Client(channel: channel)
        
        let request = makeAllergyObj(allergies: patientAllergies,
                                     patientId: patientId,
                                     appointmentId: appointmentId)
        
        let putAllergy = allergiestClient.saveNewAllergy(request)
        
        do {
            let response = try putAllergy.response.wait()
            completion(true)
            print("Allergies Put Client Successful: \(response.allergyID)")
        } catch {
            print("Allergies Put Client Failure")
        }
        
    }

    func makeAllergyObj (allergies:String,
                         patientId:String,
                         appointmentId:String) -> Nambadoctor_V1_AllergyObject {
        return Nambadoctor_V1_AllergyObject.with {
            $0.allergies = allergies
            $0.patientID = patientId
            $0.appointmentID = appointmentId
            //$0.createdDateTime =
        }
    }
}
