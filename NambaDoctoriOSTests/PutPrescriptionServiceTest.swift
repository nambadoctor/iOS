//
//  PutPrescriptionServiceTest.swift
//  NambaDoctoriOSTests
//
//  Created by Surya Manivannan on 14/02/21.
//

import XCTest
@testable import NambaDoctoriOS

class PutPrescriptionServiceTest: XCTestCase {
    var putPrescriptionService:PutPrescriptionViewModelProtocol!
    var newPrescriptionVM:PrescriptionViewModel!
    var ammendPrescriptionVM:PrescriptionViewModel!
    
    override func setUp() {
        self.putPrescriptionService = PutPrescriptionViewModel()
        
        self.newPrescriptionVM = PrescriptionViewModel(
            appointment: MakeMockAppointment.getAppointment(),
            isNewPrescription: true,
            docObjectHelper: MockGetDoctorObjectService())
        
        self.ammendPrescriptionVM = PrescriptionViewModel(
            appointment: MakeMockAppointment.getAppointment(),
            isNewPrescription: false,
            docObjectHelper: MockGetDoctorObjectService())
    }
    
    func testPutNewPrescription () {
        let expectation = XCTestExpectation(description: "Put New Prescription")
        
        AuthTokenId = "ND_Test_"
        
        putPrescriptionService.writePrescriptionToDB(prescriptionViewModel: newPrescriptionVM) { (success) in
            
            XCTAssertTrue(success)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testPutAmmendPrescription () {
        let expectation = XCTestExpectation(description: "Put Ammend Prescription")
        
        AuthTokenId = "ND_Test_"
        
        putPrescriptionService.writePrescriptionToDB(prescriptionViewModel: ammendPrescriptionVM) { (success) in
            
            XCTAssertTrue(success)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
}
