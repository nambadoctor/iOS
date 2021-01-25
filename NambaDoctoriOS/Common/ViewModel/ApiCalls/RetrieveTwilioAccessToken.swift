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
                               _ completion: @escaping ((_ success:Bool, _ twilioToke:String?)->())) {
        
        ApiGetCall.get(extensionURL: "videoroom/\(appointmentId)") { (data) in
            do {
                let tokenMap = try JSONDecoder().decode([String:String].self, from: data)
                let tokenString = tokenMap["accessToken"]
                TwilioAccessTokenString = tokenString!
                completion(true, TwilioAccessTokenString)
            } catch {
                print(error)
                completion(false, nil)
            }
        }
    }
}
