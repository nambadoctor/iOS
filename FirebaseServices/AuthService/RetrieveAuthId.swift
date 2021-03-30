//
//  RetrieveAuthId.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 18/03/21.
//

import Foundation
import Firebase

var AuthTokenId:String = ""

class RetrieveAuthId {
    
    private var stopwatch = StopwatchManager()
    
    func getAuthId (_ completion: @escaping (_ success:Bool)->()) {
        stopwatch.start()
        if Auth.auth().currentUser != nil {
            Auth.auth().currentUser?.getIDToken(completion: { (token, err) in
                if err == nil {
                    self.stopwatch.stop()
                    AuthTokenId = token!
                    print("AUTH ID:")
                    print(AuthTokenId)
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
