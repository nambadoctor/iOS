//
//  LogonServiceTest.swift
//  NambaDoctoriOSTests
//
//  Created by Surya Manivannan on 14/02/21.
//

import XCTest
@testable import NambaDoctoriOS

class LogonServiceTest: XCTestCase {
    func testGetUserType () {
        let expectation = XCTestExpectation(description: "Get Correct User Type")
        
        AuthTokenId = "ND_Test_"
        let channel = ChannelManager.testChannelManager.getChannel()
        let callOptions = ChannelManager.testChannelManager.getCallOptions()
        
        // Provide the connection to the generated client.
        let logonClient = Nambadoctor_V1_LogonWorkerV1Client(channel: channel)

        let request = Nambadoctor_V1_LogonRequestUserType.with {
            $0.phoneNumber = "+911234567890"
            $0.userID = "userId"
        }

        let getUserType = logonClient.getUserType(request, callOptions: callOptions)

        do {
            let response = try getUserType.response.wait()
            XCTAssertNotNil(response, "No data was downloaded.")
            
            expectation.fulfill()
        } catch {
            print("UserTypeClient failed: \(error)")
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
}
