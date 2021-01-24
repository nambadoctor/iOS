//
//  MockRetrieveFollowUpObjService.swift
//  NambaDoctoriOSTests
//
//  Created by Surya Manivannan on 23/01/21.
//

import Foundation
@testable import NambaDoctoriOS

class MockRetrieveFollowUpObjService: RetrieveFollowUpFeeObjProtocol {
    
    var hasFollowUp:Bool = false

    func getNextFee(patientId: String, _ completion: @escaping ((PatientFollowUpObj?) -> ())) {
        if hasFollowUp {
            let mockNextFeeObj = MakeMockFollowUp.getFollowUp()
            completion(mockNextFeeObj)
        } else {
            completion(nil)
        }
    }
}
