//
//  PutFollowUpServiceTest.swift
//  NambaDoctoriOSTests
//
//  Created by Surya Manivannan on 14/02/21.
//

import XCTest
@testable import NambaDoctoriOS

class PutFollowUpServiceTest: XCTestCase {
    var putFollowUpService:PutFollowUpAppointmentViewModelProtocol!
    
    override func setUp() {
        self.putFollowUpService = PutFollowUpAppointmentViewModel(getDocObjHelper: MockGetDoctorObjectService())
    }
    
    func testMakeFollowUpWithFollowUpVMSuccessFull () {
        
        let followUpVM:FollowUpAppointmentViewModel = FollowUpAppointmentViewModel(generalDoctorHelpers: MockGeneralDoctorHelpers())
        
        let expectation = XCTestExpectation(description: "Making FollowUp Using Prescription View model")
        
        AuthTokenId = "ND_Test_iOS"

        putFollowUpService.makeFollowUpAppointment(followUpVM: followUpVM, patientId: "patientId") { (success) in
            
            XCTAssertTrue(success)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testMakeFollowUpWithPrescriptionVMSuccessFull () {
        
        let prescriptionVM:ServiceRequestViewModel = MockPrescriptionViewModel.getNewPrescriptionVM()
        
        let expectation = XCTestExpectation(description: "Making FollowUp Using Prescription View model")

        AuthTokenId = "ND_Test_iOS"
        
        putFollowUpService.makeFollowUpAppointment(prescriptionVM: prescriptionVM) { (success) in
            XCTAssertTrue(success)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
}
