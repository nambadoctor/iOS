//
//  CleanDoubleExtension.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 22/01/21.
//

import Foundation

extension Double {
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
