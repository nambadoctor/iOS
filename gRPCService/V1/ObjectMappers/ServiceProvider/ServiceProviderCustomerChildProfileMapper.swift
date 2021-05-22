//
//  ServiceProviderCustomerChildProfileMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/22/21.
//

import Foundation

class ServiceProviderCustomerChildProfileMapper {
    static func LocalToGrpc (child:ServiceProviderCustomerChildProfile) -> Nd_V1_ServiceProviderCustomerChildProfileMessage {
        return Nd_V1_ServiceProviderCustomerChildProfileMessage.with {
            $0.childProfileID = child.ChildProfileId.toProto
            $0.name = child.Name.toProto
            $0.age = child.Age.toProto
            $0.gender = child.Gender.toProto
            $0.gender = child.PreferredPhoneNumber.toProto
        }
    }

    static func LocalToGrpc (children:[ServiceProviderCustomerChildProfile]) -> [Nd_V1_ServiceProviderCustomerChildProfileMessage] {
        var toReturn:[Nd_V1_ServiceProviderCustomerChildProfileMessage] = [Nd_V1_ServiceProviderCustomerChildProfileMessage]()

        for child in children {
            toReturn.append(LocalToGrpc(child: child))
        }

        return toReturn
    }

    static func GrpcToLocal (child:Nd_V1_ServiceProviderCustomerChildProfileMessage) -> ServiceProviderCustomerChildProfile {
        return ServiceProviderCustomerChildProfile(ChildProfileId: child.childProfileID.toString,
                                    Name: child.name.toString,
                                    Age: child.age.toString,
                                    Gender: child.gender.toString,
                                    PreferredPhoneNumber: child.preferredPhoneNumber.toString)
    }

    static func GrpcToLocal (children:[Nd_V1_ServiceProviderCustomerChildProfileMessage]) -> [ServiceProviderCustomerChildProfile] {
        var toReturn:[ServiceProviderCustomerChildProfile] = [ServiceProviderCustomerChildProfile]()

        for child in children {
            toReturn.append(GrpcToLocal(child: child))
        }

        return toReturn
    }
}
