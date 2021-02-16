//
//  MockFollowUpAptData.swift
//  NambaDoctoriOSTests
//
//  Created by Surya Manivannan on 23/01/21.
//

import Foundation
@testable import NambaDoctoriOS

class MakeMockFollowUp {
    static func getFollowUp () -> FollowUp {
        return FollowUp(id: "", patientID: "", doctorID: "", discountedFee: 300, nofDays: 10, createdDateTime: 0, appointmentID: "")
    }
}

