//
//  TwilioTokenServiceTests.swift
//  NambaDoctoriOSTests
//
//  Created by Surya Manivannan on 14/02/21.
//

import XCTest
@testable import NambaDoctoriOS
class TwilioTokenServiceTests: XCTestCase {
    func testGettingTwilioToken () {
        let expectation = XCTestExpectation(description: "Get Twilio Token")
        
        AuthTokenId = "ND_Test_"
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        let twilioClient = Nambadoctor_V1_TwilioWorkerV1Client(channel: channel)
        
        let request = Nambadoctor_V1_TwilioRequest.with {
            $0.uid = AuthTokenId
            $0.roomID = "appointmentId"
        }
        
        let getTwilioToken = twilioClient.getTwilioToken(request, callOptions: callOptions)
        
        do {
            let response = try getTwilioToken.response.wait()
            XCTAssertNotNil(response, "No data was downloaded.")
            
            expectation.fulfill()
        } catch {
            print("UserTypeClient failed: \(error)")
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
}
