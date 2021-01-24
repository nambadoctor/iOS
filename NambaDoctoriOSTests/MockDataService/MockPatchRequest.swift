//
//  MockPatchRequest.swift
//  NambaDoctoriOSTests
//
//  Created by Surya Manivannan on 21/01/21.
//

import Foundation
@testable import NambaDoctoriOS

class MockPatchRequest: ApiPatchProtocol {
    static func patch(parameters: [String : Any], extensionURL: String, _ completion: @escaping (Bool) -> ()) {
        // return success completion
    }
}
