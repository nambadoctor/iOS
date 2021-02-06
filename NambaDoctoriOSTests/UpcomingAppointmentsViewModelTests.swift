//
//  AppointmentsViewModelTests.swift
//  NambaDoctoriOSTests
//
//  Created by Surya Manivannan on 21/01/21.
//

import XCTest
@testable import NambaDoctoriOS

class UpcomingAppointmentsViewModelTests: XCTestCase {
    var appointmentsVM:UpcomingAppointmentViewModel!
    var mockUpdateStatus:MockUpdateAptStatusService!
    var mockTwilioAccessTokenService:MockTwilioTokenAccessService!
    var mockDocNotifHelper:MockDoctorNotifHelper!
    
    override func setUp() {
        mockUpdateStatus = MockUpdateAptStatusService()
        mockTwilioAccessTokenService = MockTwilioTokenAccessService()
        mockDocNotifHelper = MockDoctorNotifHelper()
        
        let mockAppointment = MakeMockAppointment.getAppointment()
        appointmentsVM = .init(appointment: mockAppointment,
                               updateAppointmentStatus: mockUpdateStatus,
                               twilioAccessTokenHelper: mockTwilioAccessTokenService,
                               notifHelper: mockDocNotifHelper)
        
    }
    
    func testShowCancelAppointmentWhenStatusIsConfirmed() {
        appointmentsVM.appointment.status = ConsultStateK.Confirmed.rawValue
        appointmentsVM.checkToShowCancelButton()
        
        XCTAssertTrue(appointmentsVM.showCancelButton)
    }

    func testDoNotShowCancelAppointmentWhenStatusIsStartedConsultation() {
        appointmentsVM.appointment.status = ConsultStateK.StartedConsultation.rawValue
        appointmentsVM.checkToShowCancelButton()
        
        XCTAssertFalse(appointmentsVM.showCancelButton)
    }

    func testDoNotShowCancelAppointmentWhenStatusIsFinishedAppointment() {
        appointmentsVM.appointment.status = ConsultStateK.FinishedAppointment.rawValue
        appointmentsVM.checkToShowCancelButton()
        
        XCTAssertFalse(appointmentsVM.showCancelButton)
    }
    
    func testStartConsultationButtonTogglesTwilioRoomTrue() {
        mockTwilioAccessTokenService.isTokenRetrieved = true
        mockUpdateStatus.updateStartConsultationSuccess = true
        appointmentsVM.startConsultation()
        
        XCTAssertTrue(appointmentsVM.takeToTwilioRoom)
    }
    
    func testStartConsultationButtonTogglesTwilioRoomFalse() {
        mockTwilioAccessTokenService.isTokenRetrieved = false
        appointmentsVM.startConsultation()
        
        XCTAssertFalse(appointmentsVM.takeToTwilioRoom)
    }
    
    func testWritePrescriptionTogglesConsultationDoneToTrue() {
        appointmentsVM.writePrescription()
        
        XCTAssertTrue(appointmentsVM.consultationDone)
    }
}
