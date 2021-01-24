//
//  ApiPutCall.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 23/01/21.
//

import Foundation
import Alamofire

class ApiPutCall : ApiPutProtocol {
    static func put (parameters:[String:Any], extensionURL:String, _ completion : @escaping (_ success:Bool, _ data:Data?)->()) {
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "AuthenticationToken": "\(AuthTokenId)"
        ]

        AF.request("\(baseUrl)\(extensionURL)", method: .put, parameters: parameters, encoding: CustomParamEncoding(), headers: headers)
            .response { (response) in
                switch response.result {
                case .success:
                    print("PUT SUCCESS")
                    completion(true, response.data ?? nil)
                case let .failure(error):
                    print("PUT FAILURE")
                    completion(false, nil)
                    print(error)
                }
            }
    }
}
