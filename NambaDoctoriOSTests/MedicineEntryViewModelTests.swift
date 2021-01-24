//
//  MedicineEntryViewModelTests.swift
//  NambaDoctoriOSTests
//
//  Created by Surya Manivannan on 23/01/21.
//

import XCTest
@testable import NambaDoctoriOS

class MedicineEntryViewModelTests: XCTestCase {
    var medicineEntryVM:MedicineEntryViewModel!
    var generalDoctorHelpers:MockGeneralDoctorHelpers!

    override func setUp() {
        generalDoctorHelpers = MockGeneralDoctorHelpers()
        medicineEntryVM = .init(generalDoctorHelpers: generalDoctorHelpers)
    }

    func testTimingStringReturnCleanedUpDoubleString() {
        medicineEntryVM.morningTemp = 1.0
        medicineEntryVM.noonTemp = 0.0
        medicineEntryVM.eveningTemp = 1.5
        medicineEntryVM.nightTemp = 1.0
        
        XCTAssertEqual(medicineEntryVM.timingString, "1,0,1.5,1")
    }

    func testMapExistingValuesWorks() {
        let tempMed = MakeMockMedicine.getMedicine()
        medicineEntryVM.mapExistingMedicine(medicine: tempMed)

        XCTAssertEqual(medicineEntryVM.medicineName, "dolo")
        XCTAssertEqual(medicineEntryVM.dosage, "350mg")
        XCTAssertEqual(medicineEntryVM.noSpecificDuration, false)
        XCTAssertEqual(medicineEntryVM.tempNumOfDays, "10")
        XCTAssertEqual(medicineEntryVM.timeIndex, 0)
        XCTAssertEqual(medicineEntryVM.inTakeIndex, 1)
        XCTAssertEqual(medicineEntryVM.routeOfAdminIndex, 1)
        XCTAssertEqual(medicineEntryVM.foodSelectionIndex, 0)
        XCTAssertEqual(medicineEntryVM.morningTemp, 0.0)
        XCTAssertEqual(medicineEntryVM.noonTemp, 0.5)
        XCTAssertEqual(medicineEntryVM.eveningTemp, 1.5)
        XCTAssertEqual(medicineEntryVM.nightTemp, 0.0)
    }

    func testClearValuesFunctionWorking() {
        medicineEntryVM.clearValues()

        XCTAssertEqual(medicineEntryVM.medicineName, "")
        XCTAssertEqual(medicineEntryVM.dosage, "")
        XCTAssertEqual(medicineEntryVM.noSpecificDuration, false)
        XCTAssertEqual(medicineEntryVM.tempNumOfDays, "")
        XCTAssertEqual(medicineEntryVM.timeIndex, 0)
        XCTAssertEqual(medicineEntryVM.inTakeIndex, 0)
        XCTAssertEqual(medicineEntryVM.routeOfAdminIndex, 0)
        XCTAssertEqual(medicineEntryVM.foodSelectionIndex, 0)
        XCTAssertEqual(medicineEntryVM.morningTemp, 0.0)
        XCTAssertEqual(medicineEntryVM.noonTemp, 0.0)
        XCTAssertEqual(medicineEntryVM.eveningTemp, 0.0)
        XCTAssertEqual(medicineEntryVM.nightTemp, 0.0)
    }
}
