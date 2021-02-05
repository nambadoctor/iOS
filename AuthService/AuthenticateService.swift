//
//  AuthenticateNumber.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 13/01/21.
//

import Foundation
import FirebaseAuth
import GRPC

class AuthenticateService : AuthenticateServiceProtocol {

    func getUserId () -> String {
        return Auth.auth().currentUser?.uid ?? "Not not logged in"
    }

    func verifyNumber (phNumber:String, completion: @escaping (_ userId:String?) -> ()) {
        PhoneAuthProvider.provider().verifyPhoneNumber(phNumber, uiDelegate: nil) { (verificationId, err) in

            if let err = err {
                print(err)
                completion(nil)
            }

            if let verificationId = verificationId {
                completion(verificationId)
            } else {
                completion(nil)
            }
        }
    }

    //verify with otp
    func verifyUser (verificationId:String, otp:String, completion: @escaping (_ userVerified:Bool) -> ()) {
        let credentials = PhoneAuthProvider.provider().credential(withVerificationID: verificationId, verificationCode: otp)

        Auth.auth().signIn(with: credentials) { (res, err) in
            if let err = err {
                print(err.localizedDescription)
                completion(false)
            } else {
                completion(true)
            }
        }
    }
}

//MARK: HELPERS FOR AUTH SERVICE
extension AuthenticateService {
    func validatePhoneNumber (_ phoneNumber:String) -> Bool {
        if phoneNumber.count < 10 { return false }
        
        if phoneNumber.count > 10 { return false }
        
        return true
    }
}
