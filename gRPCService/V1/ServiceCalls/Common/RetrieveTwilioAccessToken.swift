//
//  RetrieveTwilioAccessToken.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 20/01/21.
//

import Foundation

//global string because init function with ViewController is buggy
var TwilioAccessTokenString = ""

class RetrieveTwilioAccessToken : TwilioAccessTokenProtocol {
    func retrieveToken (appointmentId:String,
                        userId:String,
                        completion: @escaping ((_ success:Bool, _ twilioToke:String?)->())) {
                
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        let twilioClient = Nd_V1_TwilioWorkerV1Client(channel: channel)
        
        let request = Nd_V1_TwilioAuthRequest.with {
            $0.roomID = appointmentId.toProto
            $0.userID = userId.toProto
        }

        let getTwilioToken = twilioClient.getTwilioVideoAuthToken(request, callOptions: callOptions)
        
        DispatchQueue.global().async {
            do {
                let response = try getTwilioToken.response.wait()
                let twilioToken = response.message.toString
                print("TwilioToken received: \(twilioToken)")
                DispatchQueue.main.async {
                    TwilioAccessTokenString = twilioToken
                    completion(true, twilioToken)
                }
            } catch {
                print("TwilioToken failed: \(error)")
                completion(false, nil)
            }
        }
        
    }
}
