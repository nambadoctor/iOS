//
//  GetReceptientFCMTokenId.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 20/01/21.
//

import Foundation

class GetReceptientFCMTokenId {
    static func getPatientTokenId (patientId: String,
                                   _ completion: @escaping ((_ tokenId:String?)->())) {
        
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let getPatientClient = Nambadoctor_V1_PatientWorkerV1Client(channel: channel)
        
        let request = Nambadoctor_V1_PatientRequest.with {
            $0.patientID = patientId
        }
        
        let getPatient = getPatientClient.getPatientObject(request)
        
        do {
            let response = try getPatient.response.wait()
            completion(response.deviceTokenID)
            print("Get Patient Client Success")
        } catch {
            print("Get Patient Client Failure")
        }
    }
}
