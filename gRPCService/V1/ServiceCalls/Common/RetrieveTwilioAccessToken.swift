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
    
    var getDocObject:GetDocObjectProtocol
    
    init(getDocObject:GetDocObjectProtocol = GetDocObject()) {
        self.getDocObject = getDocObject
    }
    
    func retrieveToken (appointmentId:String,
                               _ completion: @escaping ((_ success:Bool, _ twilioToke:String?)->())) {
                
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        let twilioClient = Nambadoctor_V1_TwilioWorkerV1Client(channel: channel)
        
        let request = Nambadoctor_V1_TwilioRequest.with {
            $0.uid = getDocObject.getDoctor().doctorID
            $0.roomID = appointmentId
        }

        let getTwilioToken = twilioClient.getTwilioToken(request, callOptions: callOptions)
        
        do {
            let response = try getTwilioToken.response.wait()
            let twilioToken = response.authToken
            print("TwilioToken received: \(twilioToken)")
            completion(true, twilioToken)
            TwilioAccessTokenString = twilioToken
        } catch {
            print("TwilioToken failed: \(error)")
            completion(false, nil)
        }
    }
}
