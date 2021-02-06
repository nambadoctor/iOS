//
//  MockFollowUpAptData.swift
//  NambaDoctoriOSTests
//
//  Created by Surya Manivannan on 23/01/21.
//

import Foundation
@testable import NambaDoctoriOS

class MakeMockFollowUp {
    static func getFollowUp () -> Nambadoctor_V1_FollowUpObject {
        return Nambadoctor_V1_FollowUpObject.with {
            $0.id = "followUpObjId"
            $0.patientID = "patientId"
            $0.doctorID = "doctorId"
            $0.discountedFee = 300
            $0.nofDays = 10
            $0.createdDateTime = 0
        }
    }
}

