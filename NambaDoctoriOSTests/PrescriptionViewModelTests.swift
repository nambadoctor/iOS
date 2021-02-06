//
//  PrescriptionViewModelTests.swift
//  NambaDoctoriOSTests
//
//  Created by Surya Manivannan on 22/01/21.
//

import XCTest
@testable import NambaDoctoriOS

class PrescriptionViewModelTests: XCTestCase {
    var prescriptionVM:PrescriptionViewModel!
    var mockRetrievePrescriptionService:MockRetrievePrescriptionService!
    var mockRetrieveFollowUpService:MockRetrieveFollowUpObjService!
    var mockRetrieveAllergiesService:MockRetrieveAllergiesService!
    var mockGetDocObjService:MockGetDoctorObjectService!
    
    override func setUp() {
        let mockAppointment = MakeMockAppointment.getAppointment()

        mockRetrievePrescriptionService = MockRetrievePrescriptionService()
        mockRetrieveFollowUpService = MockRetrieveFollowUpObjService()
        mockRetrieveAllergiesService = MockRetrieveAllergiesService()
        mockGetDocObjService = MockGetDoctorObjectService()
        
        prescriptionVM = .init(appointment: mockAppointment,
                               isNewPrescription: true,
                               docObjectHelper: mockGetDocObjService,
                               retrievePrescriptionHelper: mockRetrievePrescriptionService,
                               retrieveFollowUpObjHelper: mockRetrieveFollowUpService,
                               retrieveAllergiesHelper: mockRetrieveAllergiesService)
    }

    func testRetrievePrescriptionShouldReturnNonNullPrescription() {
        mockRetrievePrescriptionService.retrievePrescriptionSuccess = true
        prescriptionVM.retrievePrescription()

        XCTAssertFalse(prescriptionVM.errorInRetrievingPrescription)
    }

    func testRetrievePrescriptionShouldReturnNullPrescription() {
        mockRetrievePrescriptionService.retrievePrescriptionSuccess = false
        prescriptionVM.retrievePrescription()

        XCTAssertTrue(prescriptionVM.errorInRetrievingPrescription)
    }

    func testRetrieveFollowUpShouldPopulateValuesInFollowUpVM() {
        mockRetrieveFollowUpService.hasFollowUp = true
        prescriptionVM.retrieveFollowUpFeeForPrescription()

        XCTAssertEqual(prescriptionVM.FollowUpVM.nextFeeHelperString, "300")
        XCTAssertEqual(prescriptionVM.FollowUpVM.validDaysHelperString, "10")
    }

    func testRetrieveAllergiesShouldPopulateSuccessfully() {
        mockRetrieveAllergiesService.hasAllergies = true
        prescriptionVM.retrieveAllergiesForPatient()

        XCTAssertEqual(prescriptionVM.patientAllergies, "insulin")
    }
    
    func testSendToReviewPrescriptionWithNonEmptyInvestigationTemp() {
        prescriptionVM.InvestigationsVM.investigationTemp = "empty"
        prescriptionVM.sendToReviewPrescription()

        XCTAssertEqual(prescriptionVM.InvestigationsVM.investigations.count, 1)
        XCTAssertTrue(prescriptionVM.navigateToReviewPrescription)
    }
}
