//
//  DeviceInformationMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/23/21.
//

import Foundation

class DeviceInformationMapper {
    static func LocalToGrpc (deviceInfo:DeviceInformation) -> Nd_V1_DeviceInfoMessage {
        return Nd_V1_DeviceInfoMessage.with {
            $0.brand = deviceInfo.Brand.toProto
            $0.osversion = deviceInfo.OSVersion.toProto
            $0.deviceName = deviceInfo.DeviceName.toProto
            $0.model = deviceInfo.Model.toProto
            $0.product = deviceInfo.Product.toProto
            $0.display = deviceInfo.Display.toProto
            $0.cpuAbi = deviceInfo.CPU_ABI.toProto
            $0.cpuAbi2 = deviceInfo.CPU_ABI2.toProto
            $0.manufacturer = deviceInfo.Manufacturer.toProto
            $0.serial = deviceInfo.Serial.toProto
        }
    }
    
    static func GrpcToLocal (deviceInfo: Nd_V1_DeviceInfoMessage) -> DeviceInformation {
        return DeviceInformation(DeviceInfoId: deviceInfo.deviceInfoID.toString,
                                 OSVersion: deviceInfo.osversion.toString,
                                 DeviceName: deviceInfo.deviceName.toString,
                                 Model: deviceInfo.model.toString,
                                 Product: deviceInfo.product.toString,
                                 Brand: deviceInfo.brand.toString,
                                 Display: deviceInfo.display.toString,
                                 CPU_ABI: deviceInfo.cpuAbi.toString,
                                 CPU_ABI2: deviceInfo.cpuAbi2.toString,
                                 Manufacturer: deviceInfo.manufacturer.toString,
                                 Serial: deviceInfo.serial.toString)
    }
}
