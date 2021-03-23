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
    static func getAuthId (_ completion: @escaping (_ success:Bool)->()) {
        if Auth.auth().currentUser != nil {
            Auth.auth().currentUser?.getIDToken(completion: { (token, err) in
                if err == nil {
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
