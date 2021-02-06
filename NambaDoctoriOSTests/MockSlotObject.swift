//
//  MockLatestSLotObj.swift
//  NambaDoctoriOSTests
//
//  Created by Surya Manivannan on 05/02/21.
//

import Foundation
@testable import NambaDoctoriOS

class MockSlotObject {
    
    static func getSlot() -> Nambadoctor_V1_SlotObject {
        return Nambadoctor_V1_SlotObject.with {
            $0.id = ""
            $0.doctorID = ""
            $0.bookedBy = ""
            $0.duration = 10
            $0.startDateTime = 0
            $0.status = ""
            $0.createdDateTime = 0
        }
    }
    
    static func getLatestSlot() -> Nambadoctor_V1_LatestSlot {
        return Nambadoctor_V1_LatestSlot.with {
            $0.id = ""
            $0.doctorID = ""
            $0.bookedBy = ""
            $0.duration = 10
            $0.startDateTime = 0
            $0.status = ""
            $0.createdDateTime = 0
        }
    }
}
