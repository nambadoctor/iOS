//
//  GetUserTypeHelper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/25/21.
//

import Foundation

class GetUserTypeHelper {
    static func getUserType() -> String {
        return UserDefaults.standard.value(forKey: "\(SimpleStateK.loginStatus)") as? String ?? ""
    }
}
