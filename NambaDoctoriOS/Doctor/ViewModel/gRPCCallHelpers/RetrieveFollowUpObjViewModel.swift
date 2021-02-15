//
//  RetrieveFollowUpObjViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 23/01/21.
//

import Foundation

class RetrieveFollowUpObjViewModel: RetrieveFollowUpFeeObjProtocol {
    
    var followUpObjMapper:FollowUpObjectMapper
    
    init(followUpObjMapper:FollowUpObjectMapper = FollowUpObjectMapper()) {
        self.followUpObjMapper = followUpObjMapper
    }
    
    func getNextFee(doctorId:String, patientId: String, _ completion: @escaping ((FollowUp?) -> ())) {
        
        CommonDefaultModifiers.showLoader()

        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        let followUpClient = Nambadoctor_V1_FollowUpWorkerV1Client(channel: channel)

        let request = Nambadoctor_V1_FollowUpRequest.with {
            $0.doctorID = doctorId
            $0.patientID = patientId
        }

        let getFollowUp = followUpClient.getNextFollowUpWithPatient(request, callOptions: callOptions)
        
        do {
            let response = try getFollowUp.response.wait()
            let followup = followUpObjMapper.grpcToLocalFollowUpObject(followup: response)
            print("UserTypeClient received: \(response)")
            CommonDefaultModifiers.hideLoader()
            completion(followup)
        } catch {
            print("UserTypeClient failed: \(error)")
            completion(nil)
        }
    }
}
