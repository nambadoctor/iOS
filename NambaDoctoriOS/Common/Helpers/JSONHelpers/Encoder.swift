//
//  JsonEncoderDecoder.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 19/01/21.
//

import Foundation

class LocalEncoder {
    static func encode<Value>(payload: Value, destination:String) where Value : Encodable {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(payload)
            UserDefaults.standard.set(data, forKey: destination)
        } catch let err {
            print(err)
        }
    }
}
