//
//  UpdateAppointmentStatusServiceTest.swift
//  NambaDoctoriOSTests
//
//  Created by Surya Manivannan on 14/02/21.
//

import XCTest
@testable import NambaDoctoriOS

class UpdateAppointmentStatusServiceTest: XCTestCase {
    var updateAppointmentService:UpdateAppointmentStatusProtocol!
    
    override func setUp() {
        self.updateAppointmentService = UpdateAppointmentStatusViewModel()
    }
    
    func testUpdateAppointmentStatusSuccessful () {
        let expectation = XCTestExpectation(description: "Update Appointment Status Test")
        
        AuthTokenId = "ND_Test_"
        
        updateAppointmentService.makeAppointmentUpdate(appointment: MakeMockAppointment.getAppointment()) { (success) in
            XCTAssertTrue(success)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
}
