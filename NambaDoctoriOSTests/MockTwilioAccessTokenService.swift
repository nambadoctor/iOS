//
//  MockTwilioAccessTokenService.swift
//  NambaDoctoriOSTests
//
//  Created by Surya Manivannan on 22/01/21.
//

@testable import NambaDoctoriOS

class MockTwilioTokenAccessService: TwilioAccessTokenProtocol {
    
    var isTokenRetrieved:Bool = true
    var retrievedToken:String? = nil

    func retrieveToken(appointmentId: String, _ completion: @escaping ((Bool, String?) -> ())) {
        completion(isTokenRetrieved, retrievedToken)
    }
}
