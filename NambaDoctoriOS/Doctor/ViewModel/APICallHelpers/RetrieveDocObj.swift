//
//  RetrieveDocObj.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 19/01/21.
//

import Foundation

class RetrieveDocObj {
    static func getDoc (_ completion : @escaping (_ DoctorObj:Doctor)->()) {
        ApiGetCall.get(extensionURL: "doctor") { (data) in
            do {
                let decodedResponse = try JSONDecoder().decode(Doctor.self, from: data)
                completion(decodedResponse)
            } catch let err {
                print(err)
            }
        }
    }
}


