//
//  Protocols.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 21/01/21.
//

import Foundation

protocol ApiGetProtocol {
    static func get (extensionURL:String, _ completion : @escaping (_ data:Data)->())
}

protocol ApiPatchProtocol {
    static func patch (parameters:[String:Any], extensionURL:String, _ completion : @escaping (_ success:Bool)->())
}

protocol ApiPostProtocol {
    static func post (parameters:[String:Any], extensionURL:String, _ completion : @escaping (_ success:Bool, _ data:Data?)->())
}

protocol ApiPutProtocol {
    static func put (parameters:[String:Any], extensionURL:String, _ completion : @escaping (_ success:Bool, _ data:Data?)->())
}

