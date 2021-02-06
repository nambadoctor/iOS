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
    
    func getNextFee (doctorId:String, patientId:String, _ completion: @escaping ((_ nextFeeObj:Nambadoctor_V1_FollowUpObject?)->())) {
        if hasFollowUp {
            let mockNextFeeObj = MakeMockFollowUp.getFollowUp()
            completion(mockNextFeeObj)
        } else {
            completion(nil)
        }
    }
}
