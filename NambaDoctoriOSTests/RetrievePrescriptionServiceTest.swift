//
//  RetrievePrescriptionServiceTest.swift
//  NambaDoctoriOSTests
//
//  Created by Surya Manivannan on 14/02/21.
//

import XCTest
@testable import NambaDoctoriOS

class RetrievePrescriptionServiceTest: XCTestCase {
    var retrievePrescriptionService:RetrievePrescriptionForAppointmentProtocol!
    
    override func setUp() {
        self.retrievePrescriptionService = RetrieveServiceRequestForAppointmentViewModel()
    }
    
    func testGetFollowUpServiceSuccess () {
        let expectation = XCTestExpectation(description: "Retrieve Prescription Object")
        
        AuthTokenId = "ND_Test_iOS"
        
        retrievePrescriptionService.getPrescription(appointmentId: "appointmentId") { (prescriptionObj) in
            
            XCTAssertNotNil(prescriptionObj, "no data found")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
}
