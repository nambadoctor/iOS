//
//  AuthenticationServiceProtocol.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 20/01/21.
//

import Foundation

protocol AuthenticateServiceProtocol {
    func verifyNumber (phNumber:String, completion: @escaping (_ userId:String?) -> ())
    
    func verifyUser (verificationId:String, otp:String, completion: @escaping (_ userVerified:Bool) -> ())
    
    func validatePhoneNumber (_ phoneNumber:String) -> Bool
    
    func getUserId () -> String 
}
