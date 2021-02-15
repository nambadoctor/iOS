//
//  AddPatientServiceTest.swift
//  NambaDoctoriOSTests
//
//  Created by Surya Manivannan on 14/02/21.
//

import XCTest
@testable import NambaDoctoriOS

class AddPatientServiceTest: XCTestCase {
    var addPreRegPatient:AddPreRegisteredViewModel!
    var followUpVM:FollowUpAppointmentViewModel!
    
    override func setUp() {
        self.addPreRegPatient = AddPreRegisteredViewModel()
        self.followUpVM = FollowUpAppointmentViewModel(generalDoctorHelpers: MockGeneralDoctorHelpers())
    }
    
    func testAddingValidPatient () {
        let expectation = XCTestExpectation(description: "Add Patient Service Test")
        
        AuthTokenId = "ND_Test_"
        
        addPreRegPatient.preRegisterPatient(patientObj: MockPreRegPatient.mockPatientObj(),
                                            nextFeeObj: followUpVM) { (patientId) in
            
            XCTAssertNotNil(patientId, "No data was downloaded.")
            
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10.0)
    }
}
