//
//  RetrievePatientAllergiesServiceTest.swift
//  NambaDoctoriOSTests
//
//  Created by Surya Manivannan on 14/02/21.
//

import XCTest
@testable import NambaDoctoriOS

class RetrievePatientAllergiesServiceTest: XCTestCase {
    var retrieveAllergiesService:RetrievePatientAllergiesProtocol!
    
    override func setUp() {
        self.retrieveAllergiesService = RetrievePatientAllergiesViewModel()
    }
    
    func testGetAllergiesSuccessful () {
        
        let expectation = XCTestExpectation(description: "Get Patient Allergies Successful")
        
        AuthTokenId = "ND_Test_"
        
        retrieveAllergiesService.getPatientAllergies(patientId: "patientId") { (allergies) in
            XCTAssertNotNil(allergies, "no data found")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
}
