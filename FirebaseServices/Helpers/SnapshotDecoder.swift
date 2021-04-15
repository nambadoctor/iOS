//
//  SnapshotDecoder.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/14/21.
//

import Foundation
import FirebaseDatabase
import CodableFirebase

class SnapshotDecoder {
    static func decodeSnapshot<T:Codable>(modelType: T.Type, snapshot:DataSnapshot) -> T? {
        do{
            return try FirebaseDecoder().decode(modelType.self, from: snapshot.value as Any)
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }

    static func decodeArray<T:Codable>(modelType: T.Type, array:[DataSnapshot]) -> [T] {
        var returnArray:[T] = []
        for snapshot in array {
            do{
                returnArray.append(try FirebaseDecoder().decode(modelType.self, from: snapshot.value as Any))
            } catch let error {
                print(error)
            }
        }
        return returnArray
    }

}
