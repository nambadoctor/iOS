//
//  RetrieveTwilioAccessToken.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 20/01/21.
//

import Foundation

class RetrieveTwilioAccessToken : TwilioAccessTokenProtocol {
    func retrieveToken (appointmentId:String,
                               _ completion: @escaping ((_ success:Bool, _ twilioToke:String?)->())) {
        
        ApiGetCall.get(extensionURL: "videoroom/\(appointmentId)") { (data) in
            do {
                let tokenMap = try JSONDecoder().decode([String:String].self, from: data)
                completion(true, tokenMap["accessToken"])
            } catch {
                print(error)
                completion(false, nil)
            }
        }
    }
}
