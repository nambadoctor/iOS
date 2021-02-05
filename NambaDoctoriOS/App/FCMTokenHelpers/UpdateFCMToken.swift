//
//  UpdateFCMToken.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 19/01/21.
//

import Foundation

class UpdateFCMToken {
    static func updateTokenInDB () {
        let parameters: [String: Any] = [
            "deviceTokenId":FCMTokenId
        ]

        //ApiPatchCall.patch(parameters: parameters, extensionURL: "doctor") { (success) in }
    }
}
