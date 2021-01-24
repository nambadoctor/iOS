//
//  GetReceptientFCMTokenId.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 20/01/21.
//

import Foundation

class GetReceptientFCMTokenId {
    static func getTokenId (patientId: String,
                                   _ completion: @escaping ((_ tokenId:String?)->())) {
        ApiGetCall.get(extensionURL: "patient/profile/\(patientId)") { (data) in
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
                completion(json["deviceTokenId"] as? String)
            } catch {
                print(error)
                completion(nil)
            }
        }
    }
}
