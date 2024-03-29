//
//  RetrieveAuthId.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 18/03/21.
//

import Foundation
import Firebase

var AuthTokenId:String = ""
var tokenRetrievedDate = Date()

class RetrieveAuthId {
    
    private var stopwatch = StopwatchManager(callingClass: "RETRIEVE_AUTH_TOKEN")
    
    func getAuthId (_ completion: @escaping (_ success:Bool)->()) {
        stopwatch.start()
        if Auth.auth().currentUser != nil {
            Auth.auth().currentUser?.getIDToken(completion: { (token, err) in
                if err == nil {
                    
                    self.stopwatch.stop()
                    AuthTokenId = token!
                    
                    tokenRetrievedDate = Date()
                    completion(true)
                } else {
                    completion(false)
                }
            })
        } else {
            completion(false)
        }
    }
}
