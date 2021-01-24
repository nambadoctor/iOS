//
//  MockPostRequest.swift
//  NambaDoctoriOSTests
//
//  Created by Surya Manivannan on 21/01/21.
//

import Foundation
@testable import NambaDoctoriOS

class MockPostRequest: ApiPostProtocol {
    static func post(parameters: [String : Any], extensionURL: String, _ completion: @escaping (Bool, Data?) -> ()) {
        //return (success, data) completion
    }
}
