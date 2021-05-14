//
//  ClearUserDefaults.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/14/21.
//

import Foundation

class ClearUserDefaults {
    func clear () {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
}
