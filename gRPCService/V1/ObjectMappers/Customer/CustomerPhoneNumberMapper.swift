//
//  CustomerPhoneNumberMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/26/21.
//

import Foundation

class CustomerPhoneNumberMapper {
    static func grpcPhoneNumberToLocal (phoneNumberMessage:Nd_V1_CustomerPhoneNumber) -> PhoneNumber {
        return PhoneNumber(countryCode: phoneNumberMessage.countryCode.toString,
                                      number: phoneNumberMessage.number.toString,
                                      type: phoneNumberMessage.type.toString,
                                      phoneNumberID: phoneNumberMessage.phoneNumberID.toString)
    }
    
    static func grpcPhoneNumberToLocal (phoneNumberMessages:[Nd_V1_CustomerPhoneNumber]) -> [PhoneNumber] {
        var phNumberList:[PhoneNumber] = [PhoneNumber]()
        
        for number in phoneNumberMessages {
            phNumberList.append(grpcPhoneNumberToLocal(phoneNumberMessage: number))
        }
        
        return phNumberList
    }
    
    static func localPhoneNumberToGrpc (phoneNumber:PhoneNumber) -> Nd_V1_CustomerPhoneNumber {
        return Nd_V1_CustomerPhoneNumber.with {
            $0.countryCode = phoneNumber.countryCode.toProto
            $0.number = phoneNumber.number.toProto
            $0.type = phoneNumber.type.toProto
            $0.phoneNumberID = phoneNumber.phoneNumberID.toProto
        }
    }
    
    static func localPhoneNumberToGrpc (phoneNumbers:[PhoneNumber]) -> [Nd_V1_CustomerPhoneNumber] {
        var phNumberList:[Nd_V1_CustomerPhoneNumber] = [Nd_V1_CustomerPhoneNumber]()
        
        for number in phoneNumbers {
            phNumberList.append(localPhoneNumberToGrpc(phoneNumber: number))
        }
        
        return phNumberList
    }

}
