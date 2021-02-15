//
//  PutPatientAllergiesTest.swift
//  NambaDoctoriOSTests
//
//  Created by Surya Manivannan on 14/02/21.
//

import XCTest
@testable import NambaDoctoriOS

class PutPatientAllergiesServiceTest: XCTestCase {
    var putPatientAllergiesService:PutPatientAllergiesProtocol!
    
    override func setUp() {
        self.putPatientAllergiesService = PutPatientAllergiesViewModel()
    }
}
