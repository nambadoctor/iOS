//
//  ApiPostCall.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 20/01/21.
//

import Foundation
import Alamofire

class ApiPostCall : ApiPostProtocol {
    static func post (parameters:[String:Any], extensionURL:String, _ completion : @escaping (_ success:Bool, _ data:Data?)->()) {
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "AuthenticationToken": "\(AuthTokenId)"
        ]

        AF.request("\(baseUrl)\(extensionURL)", method: .post, parameters: parameters, encoding: CustomParamEncoding(), headers: headers)
            .response { (response) in
                switch response.result {
                case .success:
                    print("POST SUCCESS")
                    completion(true, response.data ?? nil)
                case let .failure(error):
                    print("POST FAILURE")
                    completion(false, nil)
                    print(error)
                }
            }
    }
}
