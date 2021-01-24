//
//  MockAuthenticateService.swift
//  NambaDoctoriOSTests
//
//  Created by Surya Manivannan on 20/01/21.
//

@testable import NambaDoctoriOS

final class MockAuthenticateService: AuthenticateServiceProtocol {

    var numVerified:String? = "verificationId"
    var userVerified:Bool = true

    func verifyNumber(phNumber: String, completion: @escaping (String?) -> ()) {
        completion(numVerified)
    }

    func verifyUser(verificationId: String, otp: String, completion: @escaping (Bool) -> ()) {
        completion(userVerified)
    }

    func validatePhoneNumber(_ phoneNumber: String) -> Bool {
        if phoneNumber.count < 10 { return false }
        
        if phoneNumber.count > 10 { return false }
        
        return true
    }
}
