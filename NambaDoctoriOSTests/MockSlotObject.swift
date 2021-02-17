//
//  MockLatestSLotObj.swift
//  NambaDoctoriOSTests
//
//  Created by Surya Manivannan on 05/02/21.
//

import Foundation
@testable import NambaDoctoriOS

class MockSlotObject {
    
    static func getSlot() -> Slot {
        return Slot(id: "", doctorID: "", bookedBy: "", duration: 0, startDateTime: 0, status: "", createdDateTime: 0)
    }
}
