//
//  RetrievePatientInfoServiceTest.swift
//  NambaDoctoriOSTests
//
//  Created by Surya Manivannan on 14/02/21.
//

import XCTest
@testable import NambaDoctoriOS

class RetrievePatientInfoServiceTest: XCTestCase {
    var retrievePatientInfoService:RetrievePatientInfoProtocol!
    
    override func setUp() {
        self.retrievePatientInfoService = RetrievePatientInfoViewModel()
    }
    
    func testRetrievePatientProfileSuccess () {
        let expectation = XCTestExpectation(description: "Retrieve Patient Info Succes")
        
        AuthTokenId = "ND_Test_"
        
        retrievePatientInfoService.getPatientProfile(patientId: "patientId") { (patientObj) in
            XCTAssertNotNil(patientObj, "no data found")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testRetrievePatientAppointmentListSuccess () {
        let expectation = XCTestExpectation(description: "Retrieve Appointment List Success")
        
        AuthTokenId = "ND_Test_"

        retrievePatientInfoService.getPatientAppointmentList(patientId: "patientId") { (appointmentList) in
            XCTAssertNotNil(appointmentList, "no data found")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testRetrievePatientReportListSuccess () {
        let expectation = XCTestExpectation(description: "Retrieve Report List Success")
        
        AuthTokenId = "ND_Test_"
        
        retrievePatientInfoService.getUploadedReportList(appointment: MakeMockAppointment.getAppointment()) { reportList in
            
            XCTAssertNotNil(reportList, "no data found")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testRetrievePatientReportImageSuccess() {
        let expectation = XCTestExpectation(description: "Retrieve Report Image Success")
        
        AuthTokenId = "ND_Test_"
        
        retrievePatientInfoService.getReportImage(reportId: "601b91cb523ecabc6731188c") { (image) in
            XCTAssertNotNil(image, "no data found")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
}
