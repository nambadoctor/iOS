//
//  RetrieveAppointmentsServiceTest.swift
//  NambaDoctoriOSTests
//
//  Created by Surya Manivannan on 14/02/21.
//

import XCTest
@testable import NambaDoctoriOS

class RetrieveDoctorAppointmentsServiceTest: XCTestCase {
    var retrieveAppointmentService: DoctorAppointmentViewModelProtocol!
    
    override func setUp() {
        self.retrieveAppointmentService = DoctorAppointmentViewModel(getDoctorHelper: MockGetDoctorObjectService())
    }
    
    func testRetrieveAppointmentsSuccessfully () {
        let expectation = XCTestExpectation(description: "Retrieve Appointments Service")
        
        AuthTokenId = "ND_Test_"
        
        retrieveAppointmentService.retrieveDocAppointmentList { (appointmentList) in
            XCTAssertNotNil(appointmentList, "no data found")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
}
