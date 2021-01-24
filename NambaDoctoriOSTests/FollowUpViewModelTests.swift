//
//  FollowUpViewModelTests.swift
//  NambaDoctoriOSTests
//
//  Created by Surya Manivannan on 23/01/21.
//

import XCTest
@testable import NambaDoctoriOS

class FollowUpViewModelTests: XCTestCase {
    var followupVM:FollowUpAppointmentViewModel!
    
    override func setUp() {
        followupVM = .init()
    }
    
    func testTestShowEntryFieldsTogglesTrue() {
        followupVM.validDaysHelperString = "20"
        followupVM.nextFeeHelperString = "500"
        followupVM.showEntryFields()
        
        XCTAssertTrue(followupVM.needFollowUp)
    }

    func testShowEntryFieldsTogglesFalse() {
        followupVM.showEntryFields()

        XCTAssertFalse(followupVM.needFollowUp)
    }
    
    func testMapExistingFollowUpAppointmentSucccessful() {
        let followUpObj = MakeMockFollowUp.getFollowUp()
        followupVM.mapExistingValuesFromFollowUpObj(followUpObj: followUpObj)
        
        XCTAssertEqual(String(followUpObj.validityDays), followupVM.validDaysHelperString)
        XCTAssertEqual(String(followUpObj.nextAppointmentFee), followupVM.nextFeeHelperString)
    }
}
