//
//  MockRetrieveAllergiesService.swift
//  NambaDoctoriOSTests
//
//  Created by Surya Manivannan on 23/01/21.
//

import Foundation
@testable import NambaDoctoriOS

class MockRetrieveAllergiesService: RetrievePatientAllergiesProtocol {
    var hasAllergies:Bool = false
    func getPatientAllergies(patientId: String, _ completion: @escaping ((String?) -> ())) {
        if hasAllergies {
            completion("insulin")
        } else {
            completion(nil)
        }
    }
}
