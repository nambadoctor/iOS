//
//  RetrievePatientAllergiesViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 23/01/21.
//

import Foundation

class RetrievePatientAllergiesViewModel: RetrievePatientAllergiesProtocol {
    func getPatientAllergies (patientId:String, _ completion: @escaping ((_ allergies:String)->())) {
        
        CommonDefaultModifiers.showLoader()
        
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        let allergiestClient = Nambadoctor_V1_AllergyWorkerv1Client(channel: channel)
        
        let request = Nambadoctor_V1_AllergyPat.with {
            $0.patientID = patientId
        }
        
        let putAllergy = allergiestClient.getAllergyofPatient(request, callOptions: callOptions)
        
        do {
            let response = try putAllergy.response.wait()
            print("Allergies Get Client Successful: \(response.allergies)")
            CommonDefaultModifiers.hideLoader()
            completion(response.allergies)
        } catch {
            print("Allergies Get Client Failure")
        }

    }
}
