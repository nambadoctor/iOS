//
//  LogonServiceTest.swift
//  NambaDoctoriOSTests
//
//  Created by Surya Manivannan on 14/02/21.
//

import XCTest
@testable import NambaDoctoriOS

class LogonServiceTest: XCTestCase {
    
    var findUserTypeService:FindUserTypeViewModelProtocol!
    
    override func setUp() {
        self.findUserTypeService = FindDocOrPatientVM()
    }
    
    func testGetUserType () {
        let expectation = XCTestExpectation(description: "Get Correct User Type")
        
        AuthTokenId = "ND_Test_"
        
        findUserTypeService.getDocOrPatient(phoneNumber: "+911234567890") { (userStatus) in
            XCTAssertNotNil(userStatus, "No data was downloaded.")

            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
}
