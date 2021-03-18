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
    var newPrescriptionVM:ServiceRequestViewModel!
    var ammendPrescriptionVM:ServiceRequestViewModel!
    
    override func setUp() {
        doctor = MockDoctor.getDoctor()
        
        self.putPrescriptionService = PutPrescriptionViewModel()
        
        self.newPrescriptionVM = MockPrescriptionViewModel.getNewPrescriptionVM()
        
        self.ammendPrescriptionVM = MockPrescriptionViewModel.getAmmendPrescriptionVM()
    }
    
    //Actual call is working... don't know why these are failing
    func testPutNewPrescription () {
        let expectation = XCTestExpectation(description: "Put New Prescription")
        
        AuthTokenId = "ND_Test_iOS"

        putPrescriptionService.writePrescriptionToDB(prescriptionViewModel: newPrescriptionVM) { (success) in
            
            XCTAssertTrue(success)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testPutAmmendPrescription () {
        let expectation = XCTestExpectation(description: "Put Ammend Prescription")
        
        AuthTokenId = "ND_Test_iOS"
                
        putPrescriptionService.writePrescriptionToDB(prescriptionViewModel: ammendPrescriptionVM) { (success) in
            
            XCTAssertTrue(success)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
}
