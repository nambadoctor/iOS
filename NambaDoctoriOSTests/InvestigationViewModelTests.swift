//
//  InvestigationViewModelTests.swift
//  NambaDoctoriOSTests
//
//  Created by Surya Manivannan on 22/01/21.
//

import XCTest
@testable import NambaDoctoriOS

class InvestigationViewModelTests: XCTestCase {
    var investigationVM:InvestigationsViewModel!

    override func setUp() {
        investigationVM = InvestigationsViewModel()
    }

    func testAppendEmptyInvestigationsAddsToArrayRemainsEmpty() {
        investigationVM.investigationTemp = ""
        investigationVM.appendInvestigation()

        XCTAssertEqual(investigationVM.investigations.count, 0)
    }

    func testAppendInvestigationAddToArrayPopulatesArray() {
        investigationVM.investigationTemp = "sample"
        investigationVM.appendInvestigation()

        XCTAssertEqual(investigationVM.investigations.count, 1)
    }

    func testParsePlanInfoIntoInvestigationsArraySuccessfull() {
        investigationVM.parsePlanIntoInvestigationsArr(planInfo: "xray;chemo;brainscan")
        XCTAssertEqual(investigationVM.investigations.count, 3)
    }
}
