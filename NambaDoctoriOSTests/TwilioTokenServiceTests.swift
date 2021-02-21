//
//  TwilioTokenServiceTests.swift
//  NambaDoctoriOSTests
//
//  Created by Surya Manivannan on 14/02/21.
//

import XCTest
@testable import NambaDoctoriOS
class TwilioTokenServiceTests: XCTestCase {
    
    var retrieveTokenAccessToken: TwilioAccessTokenProtocol!
    
    override func setUp() {
        self.retrieveTokenAccessToken = RetrieveTwilioAccessToken()
    }
    
    func testGettingToken () {
        let expectation = XCTestExpectation(description: "Get Twilio Token")
        
        AuthTokenId = "ND_Test_iOS"
        
        retrieveTokenAccessToken.retrieveToken(appointmentId: "appointmentId") { (success, token) in
            XCTAssertNotNil(token, "No data was downloaded.")

            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
}
