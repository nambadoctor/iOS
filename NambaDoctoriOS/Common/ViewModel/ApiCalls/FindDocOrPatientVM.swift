//
//  FindDocOrPatientVM.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 17/01/21.
//

import Foundation

class FindDocOrPatientVM {
    static func getDocOrPatient (_ completion : @escaping (_ patientOrDoc:UserLoginStatus)->()) {
        ApiGetCall.get(extensionURL: "usertype") { data in
            do {
                let convertedDict = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
                
                let loginStatus = CheckLoginStatus.checkStatus(loggedInStatus: convertedDict!["userType"] as! String)
                
                completion(loginStatus)
 
            } catch let err {
                print(err.localizedDescription)
            }
        }
    }
}
