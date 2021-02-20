//
//  MedicineViewModelTests.swift
//  NambaDoctoriOSTests
//
//  Created by Surya Manivannan on 22/01/21.
//

import XCTest
@testable import NambaDoctoriOS

class MedicineViewModelTests: XCTestCase {
    var medicineVM:MedicineViewModel!
    var generalDoctorHelpers:MockGeneralDoctorHelpers!
    
    override func setUp() {
        generalDoctorHelpers = MockGeneralDoctorHelpers()
        medicineVM = .init(generalDoctorHelpers: generalDoctorHelpers)
    }
    
    func testFoodSelectionStringReturnsAsExpected() {
        setMedicineEntryTestValues()
        XCTAssertEqual(medicineVM.medFoodCorrelation, foodSelectionArray[2])
        XCTAssertEqual(medicineVM.routeOfAdministration, routeOfAdmissionArray[2])
        XCTAssertEqual(medicineVM.medInTake, medicineInTakeTimings[2])
    }
    
    func testQuantityDisplayReturnsCorrectDisplayStringTrue() {
        setMedicineEntryTestValues()
        XCTAssertEqual(medicineVM.morningQuanityDisplay, "1 1/2")
        XCTAssertEqual(medicineVM.noonQuanityDisplay, "0")
        XCTAssertEqual(medicineVM.eveQuanityDisplay, "1/2")
        XCTAssertEqual(medicineVM.nightQuanityDisplay, "0")
    }
    
    func testDismissMedicineEntrySheetTrue() {
        medicineVM.dismissMedicineEntrySheet()

        XCTAssertFalse(medicineVM.medicineEntryVM.showAddMedicineSheet)
    }

    func testFinishWritingNewMedicineReturnsEmptyFieldsError() {
        medicineVM.finishWritingMedicine(isNewMedicine: true)

        XCTAssertTrue(medicineVM.showLocalAlert)
    }

    func testFinishWritingMedicineReturnsSuccessFull() {
        setMedicineEntryTestValues()
        medicineVM.finishWritingMedicine(isNewMedicine: true)

        XCTAssertFalse(medicineVM.showLocalAlert)
        XCTAssertEqual(medicineVM.medicineArr.count, 1)
    }
    
    func testEditMedicineReturnsSuccessfull() {
        let mockMedicine = MakeMockMedicine.getMedicine()
        medicineVM.medicineArr.append(mockMedicine)

        medicineVM.editMedicineOnTap(medicineToEdit: mockMedicine)

        XCTAssertFalse(medicineVM.medicineEntryVM.isNewMedicine)
        XCTAssertTrue(medicineVM.medicineEntryVM.showAddMedicineSheet)
    }

    func testMappingMedicineValuesIsSuccessfull() {
        let medEntryVM = medicineVM.medicineEntryVM
        setMedicineEntryTestValues()
        medicineVM.mapMedicineValuesToTemp()
        
        XCTAssertEqual(medicineVM.tempMedicine.medicineName, medEntryVM.medicineName)
        XCTAssertEqual(medicineVM.tempMedicine.dosage, medEntryVM.dosage)
        XCTAssertEqual(medicineVM.tempMedicine.timings, medEntryVM.timingString)
        XCTAssertEqual(medicineVM.tempMedicine.intake, medicineVM.medInTake)
        XCTAssertEqual(medicineVM.tempMedicine.routeOfAdministration, medicineVM.routeOfAdministration)
        XCTAssertEqual(medicineVM.tempMedicine.specialInstructions, medicineVM.medFoodCorrelation)
    }
    
    func setMedicineEntryTestValues () {
        let medEntryVM = medicineVM.medicineEntryVM
        //tests for mapping existing medicine
        medEntryVM.medicineName = "paracetemol"
        medEntryVM.dosage = "500"
        medEntryVM.noSpecificDuration = true
        
        medEntryVM.foodSelectionIndex = 2
        medEntryVM.routeOfAdminIndex = 2
        medEntryVM.inTakeIndex = 2
        
        medEntryVM.morningTemp = 1.5
        medEntryVM.noonTemp = 0.0
        medEntryVM.eveningTemp = 0.5
        medEntryVM.nightTemp = 0.0
    }
}
