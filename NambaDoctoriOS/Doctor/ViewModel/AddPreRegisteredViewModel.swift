//
//  AddPreRegisteredViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 25/01/21.
//

import Foundation

class AddPreRegisteredViewModel {
    func preRegisterPatient(patientObj:Nambadoctor_V1_PatientObject, nextFeeObj:FollowUpAppointmentViewModel, _ completion : @escaping ((_ patientId:String?)->())) {
        
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let patientClient = Nambadoctor_V1_PatientWorkerV1Client(channel: channel)
        
        let request = patientObj
        
        let putPatient = patientClient.writeNewPatientObject(request)
        
        do {
            let response = try putPatient.response.wait()
            print("Add Pre-Reg Patient Failure \(response.patientID)")
            completion(response.patientID)
        } catch {
            print("Add Pre-Reg Patient Failure")
        }
    }
}
