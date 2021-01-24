//
//  ApiPatchCall.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 19/01/21.
//

import Foundation
import Alamofire

class ApiPatchCall : ApiPatchProtocol {
    static func patch (parameters:[String:Any], extensionURL:String, _ completion : @escaping (_ success:Bool)->()) {
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "AuthenticationToken": "\(AuthTokenId)"
        ]

        AF.request("\(baseUrl)\(extensionURL)", method: .patch, parameters: parameters, encoding: CustomParamEncoding(), headers: headers)
            .response { (response) in
                switch response.result {
                case .success:
                    print("PATCH SUCCESS")
                    completion(true)
                case let .failure(error):
                    print("PATCH FAILURE")
                    completion(false)
                    print(error)
                }
            }
    }
}
