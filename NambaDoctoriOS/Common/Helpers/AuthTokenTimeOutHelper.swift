//
//  AuthTokenTimeOutHelper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 6/3/21.
//

import Foundation

class AuthTokenTimeOutHelper {
    func refresh (completion: @escaping ()->()) {
        let dateDif = Calendar.current.dateComponents([.minute], from: tokenRetrievedDate, to: Date())
        
        if (dateDif.minute ?? 0) >= 45 {
            RetrieveAuthId().getAuthId { _ in
                completion()
            }
        } else {
            completion()
        }
    }
}
