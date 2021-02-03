//
//  ApiCalls.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 13/01/21.
//

import Foundation
import Alamofire

class ApiGetCall : ApiGetProtocol {
    static func get (extensionURL:String, _ completion : @escaping (_ data:Data)->()) {
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "AuthenticationToken": "\(AuthTokenId)"
        ]

        AF.request("\(baseUrl)\(extensionURL)", method: .get, encoding: JSONEncoding.default, headers: headers)
            .responseData { (response) in
                switch response.result {
                case .success:
                    print("GET SUCCESS")
                    completion(response.data!)
                case let .failure(error):
                    print("GET FAILURE")
                    print(error)
                }
            }
    }
}
