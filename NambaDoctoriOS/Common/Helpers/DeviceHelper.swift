//
//  DeviceSizeHelper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/12/21.
//

import Foundation
import Device

class DeviceHelper {

    static func getIfSmallScreen () -> Bool {
        switch Device.size() {
        case .screen3_5Inch:  return true
        case .screen4Inch:    return true
        case .screen4_7Inch:  return true
        case .screen5_5Inch:  return true
        case .screen5_8Inch:  return true
        case .screen6_1Inch:  return false
        case .screen6_5Inch:  return false
        case .screen7_9Inch:  return false
        default: return false
        }
    }
    
    static func getDeviceInfo () -> DeviceInformation {
        return DeviceInformation(DeviceInfoId: "",
                                              OSVersion: UIDevice.current.systemVersion,
                                              DeviceName: UIDevice.current.name,
                                              Model: UIDevice.current.model,
                                              Product: "\(Device.type())",
                                              Brand: "Apple",
                                              Display: "\(Device.size())",
                                              CPU_ABI: "",
                                              CPU_ABI2: "",
                                              Manufacturer: "Apple",
                                              Serial: UIDevice.current.identifierForVendor?.uuidString ?? "")
    }
}
