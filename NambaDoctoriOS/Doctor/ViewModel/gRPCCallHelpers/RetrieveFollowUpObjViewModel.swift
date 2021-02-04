//
//  RetrieveFollowUpObjViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 23/01/21.
//

import Foundation

class RetrieveFollowUpObjViewModel: RetrieveFollowUpFeeObjProtocol {
    
    func getNextFee(doctorId:String, patientId: String, _ completion: @escaping ((Nambadoctor_V1_FollowUpObject?) -> ())) {
        
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let followUpClient = Nambadoctor_V1_FollowUpWorkerV1Client(channel: channel)

        let request = Nambadoctor_V1_FollowUpRequest.with {
            $0.doctorID = doctorId
            $0.patientID = patientId
        }

        let getFollowUp = followUpClient.getNextFollowUpWithPatient(request)
        
        do {
            let response = try getFollowUp.response.wait()
            print("UserTypeClient received: \(response)")
            completion(response)
        } catch {
            print("UserTypeClient failed: \(error)")
        }
    }
}
