//
//  FinishedAppointmentsViewModelTests.swift
//  NambaDoctoriOSTests
//
//  Created by Surya Manivannan on 21/01/21.
//

import XCTest
@testable import NambaDoctoriOS

class FinishedAppointmentsViewModelTests: XCTestCase {
    var finishedAppointmentVM:FinishedAppointmentViewModel!
    var mockDoctorAlertHelper:MockDoctorAlertHelpers!
    
    override func setUp() {
        mockDoctorAlertHelper = MockDoctorAlertHelpers()
        
        let mockAppointment = MakeMockAppointment.getAppointment()
        finishedAppointmentVM = .init(appointment: mockAppointment, doctorAlertHelper: mockDoctorAlertHelper)
    }
    
    func testTakeToViewPrescriptionPressedTogglesTrue() {
        finishedAppointmentVM.takeToViewPrescription()

        XCTAssertTrue(finishedAppointmentVM.viewPrescription)
    }
    
    func testTakeToAmendPrescriptionPressedTogglesTrue() {
        finishedAppointmentVM.takeToAmendPrescription()
        
        XCTAssertTrue(finishedAppointmentVM.amendPrescription)
    }
}
