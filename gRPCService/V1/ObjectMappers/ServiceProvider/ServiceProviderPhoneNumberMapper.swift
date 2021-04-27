//
//  ServiceProviderPhoneNumberMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 17/03/21.
//

import Foundation

class ServiceProviderPhoneNumberObjectMapper {
    static func grpcPhoneNumberToLocal (phoneNumberMessage:Nd_V1_ServiceProviderPhoneNumber) -> PhoneNumber {
        return PhoneNumber(countryCode: phoneNumberMessage.countryCode.toString,
                                      number: phoneNumberMessage.number.toString,
                                      type: phoneNumberMessage.type.toString,
                                      phoneNumberID: phoneNumberMessage.phoneNumberID.toString)
    }
    
    static func grpcPhoneNumberToLocal (phoneNumberMessages:[Nd_V1_ServiceProviderPhoneNumber]) -> [PhoneNumber] {
        var phNumberList:[PhoneNumber] = [PhoneNumber]()
        
        for number in phoneNumberMessages {
            phNumberList.append(grpcPhoneNumberToLocal(phoneNumberMessage: number))
        }
        
        return phNumberList
    }
    
    static func localPhoneNumberToGrpc (phoneNumber:PhoneNumber) -> Nd_V1_ServiceProviderPhoneNumber {
        return Nd_V1_ServiceProviderPhoneNumber.with {
            $0.countryCode = phoneNumber.countryCode.toProto
            $0.number = phoneNumber.number.toProto
            $0.type = phoneNumber.type.toProto
            $0.phoneNumberID = phoneNumber.phoneNumberID.toProto
        }
    }
    
    static func localPhoneNumberToGrpc (phoneNumbers:[PhoneNumber]) -> [Nd_V1_ServiceProviderPhoneNumber] {
        var phNumberList:[Nd_V1_ServiceProviderPhoneNumber] = [Nd_V1_ServiceProviderPhoneNumber]()
        
        for number in phoneNumbers {
            phNumberList.append(localPhoneNumberToGrpc(phoneNumber: number))
        }
        
        return phNumberList
    }
    
}
