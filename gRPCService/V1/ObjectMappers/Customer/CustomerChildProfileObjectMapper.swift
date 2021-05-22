//
//  CustomerChildProfileObjectMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/22/21.
//

import Foundation

class CustomerChildProfileMapper {
    static func LocalToGrpc (child:CustomerChildProfile) -> Nd_V1_CustomerChildProfileMessage {
        return Nd_V1_CustomerChildProfileMessage.with {
            $0.childProfileID = child.ChildProfileId.toProto
            $0.name = child.Name.toProto
            $0.age = child.Age.toProto
            $0.gender = child.Gender.toProto
            $0.preferredPhoneNumber = child.PreferredPhoneNumber.toProto
        }
    }

    static func LocalToGrpc (children:[CustomerChildProfile]) -> [Nd_V1_CustomerChildProfileMessage] {
        var toReturn:[Nd_V1_CustomerChildProfileMessage] = [Nd_V1_CustomerChildProfileMessage]()
        
        for child in children {
            toReturn.append(LocalToGrpc(child: child))
        }
        
        return toReturn
    }
    
    static func GrpcToLocal (child:Nd_V1_CustomerChildProfileMessage) -> CustomerChildProfile {
        return CustomerChildProfile(ChildProfileId: child.childProfileID.toString,
                                    Name: child.name.toString,
                                    Age: child.age.toString,
                                    Gender: child.gender.toString,
                                    PreferredPhoneNumber: child.preferredPhoneNumber.toString)
    }
    
    static func GrpcToLocal (children:[Nd_V1_CustomerChildProfileMessage]) -> [CustomerChildProfile] {
        var toReturn:[CustomerChildProfile] = [CustomerChildProfile]()
        
        for child in children {
            toReturn.append(GrpcToLocal(child: child))
        }
        
        return toReturn
    }
}
