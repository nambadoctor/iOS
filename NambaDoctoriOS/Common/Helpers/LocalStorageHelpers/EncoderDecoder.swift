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
            print("STORING ERROR: \(err)")
        }
    }
}

class LocalDecoder {
    static func decode<T:Codable>(modelType: T.Type, from:String) -> T? {
        var decodedObj:T?
        if let data = UserDefaults.standard.data(forKey: from) {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()

                // Decode Note
                decodedObj = try decoder.decode(modelType.self, from: data)

            } catch {
                print("Unable to Decode Note (\(error))")
            }
        }
        
        return decodedObj ?? nil
    }
}

class RemoveStoredObject {
    static func removeForKey (key:String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
