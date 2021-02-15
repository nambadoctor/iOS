//
//  RetrieveFollowUpObjServiceTest.swift
//  NambaDoctoriOSTests
//
//  Created by Surya Manivannan on 14/02/21.
//

import XCTest
@testable import NambaDoctoriOS

class RetrieveFollowUpObjServiceTest: XCTestCase {
    var retrieveFollowUpService:RetrieveFollowUpFeeObjProtocol!
    
    override func setUp() {
        self.retrieveFollowUpService = RetrieveFollowUpObjViewModel()
    }
    
    func testGetFollowUpServiceSuccess () {
        let expectation = XCTestExpectation(description: "Retrieve FollowUp Object Test")
        
        AuthTokenId = "ND_Test_"
        
        retrieveFollowUpService.getNextFee(doctorId: "doctorId", patientId: "patientId") { (followUpObj) in
            
            XCTAssertNotNil(followUpObj, "no data found")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
}
