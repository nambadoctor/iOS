//
//  RemoveStoredObject.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 21/02/21.
//

import Foundation

class RemoveStoredObject {
    static func removeForKey (key:String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
