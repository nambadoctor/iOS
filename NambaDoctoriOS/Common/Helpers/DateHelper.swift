//
//  DateHelper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 17/02/21.
//

import Foundation

extension Date {
    var millisecondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970).rounded())
    }
    
    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds))
    }
}
