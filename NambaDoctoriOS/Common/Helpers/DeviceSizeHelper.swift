//
//  DeviceSizeHelper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/12/21.
//

import Foundation
import Device

class DeviceSizeHelper {
    static func getIfSmallScreen () -> Bool {
        switch Device.size() {
        case .screen3_5Inch:  return true
        case .screen4Inch:    return true
        case .screen4_7Inch:  return true
        case .screen5_5Inch:  return false
        case .screen5_8Inch:  return false
        case .screen6_1Inch:  return false
        case .screen6_5Inch:  return false
        case .screen7_9Inch:  return false
        default: return false
        }
    }
}
