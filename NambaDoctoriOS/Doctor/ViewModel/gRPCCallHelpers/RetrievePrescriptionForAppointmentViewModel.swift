//
//  RetrievePrescriptionForAppointment.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 22/01/21.
//

import Foundation

class RetrievePrescriptionForAppointmentViewModel : RetrievePrescriptionForAppointmentProtocol {
    func getPrescription (appointmentId:String, _ completion: @escaping ((_ prescription:Nambadoctor_V1_PrescriptionObject?)->())) {

        let channel = ChannelManager.sharedChannelManager.getChannel()
        let prescriptionClient = Nambadoctor_V1_PrescriptionWorkerV1Client(channel: channel)
        
        let request = Nambadoctor_V1_PrescriptionRequest.with {
            $0.appointmentID = appointmentId
        }

        let getPrescriptionObj = prescriptionClient.getPrescriptionOfAppointment(request)
        
        do {
            let response = try getPrescriptionObj.response.wait()
            print("PrescriptionClient received: \(response)")
            completion(response)
        } catch {
            print("PrescriptionClient failed: \(error)")
        }
    }
}
