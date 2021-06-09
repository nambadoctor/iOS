//
//  ServiceProviderMyPatientProfileMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 6/9/21.
//

import Foundation

class ServiceProviderMyPatientProfileMapper {
    static func GrpcToLocal (profileMessage:Nd_V1_ServiceProviderMyPatientsProfileMessage) -> ServiceProviderMyPatientProfile {
        return ServiceProviderMyPatientProfile(CustomerId: profileMessage.customerID.toString,
                                               IsChild: profileMessage.isChild.toBool,
                                               CareTakerId: profileMessage.careTakerID.toString,
                                               Age: profileMessage.age.toString,
                                               Gender: profileMessage.gender.toString,
                                               Name: profileMessage.name.toString)
    }
    
    static func GrpcToLocal(profileMessages:[Nd_V1_ServiceProviderMyPatientsProfileMessage]) -> [ServiceProviderMyPatientProfile] {
        var profiles:[ServiceProviderMyPatientProfile] = [ServiceProviderMyPatientProfile]()
        
        for profile in profileMessages {
            profiles.append(GrpcToLocal(profileMessage: profile))
        }
        
        return profiles
    }
}
