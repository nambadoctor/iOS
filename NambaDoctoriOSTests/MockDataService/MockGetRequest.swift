//
//  MockGetRequest.swift
//  NambaDoctoriOSTests
//
//  Created by Surya Manivannan on 21/01/21.
//

import Foundation
@testable import NambaDoctoriOS

class MockGetRequest: ApiGetProtocol {
    static func get(extensionURL: String, _ completion: @escaping (Data) -> ()) {
        //return completion for data
    }
}
