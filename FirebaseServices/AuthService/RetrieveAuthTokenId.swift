//
//  RetrieveTokenId.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 17/01/21.
//

import Foundation
import FirebaseAuth

var AuthTokenId:String = ""

class RetrieveAuthTokenId {
    static func getToken (_ completion: @escaping (_ success:Bool)->()) {
        if Auth.auth().currentUser != nil {
            Auth.auth().currentUser?.getIDToken(completion: { (token, err) in
                if err == nil {
                    AuthTokenId = token!
                    Logon().logonUser { _ in } //updates FCMTokenID
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
