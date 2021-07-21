//
//  CustomerOrganizationTimingMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 7/20/21.
//

import Foundation

class CustomerOrganisationTimingMapper {
    static func GrpcToLocal (timing:Nd_V1_CustomerOrganisationTimingMessage) -> CustomerOrganizationTiming {
        return CustomerOrganizationTiming(organisationTimingId: timing.organisationTimingID.toString,
                                                 timingDescription: timing.timingDescription.toString,
                                                 type: timing.type.toString)
    }
    
    static func GrpcToLocal (timings:[Nd_V1_CustomerOrganisationTimingMessage]) -> [CustomerOrganizationTiming] {
        var toReturn = [CustomerOrganizationTiming]()
        
        for timing in timings {
            toReturn.append(GrpcToLocal(timing: timing))
        }
        
        return toReturn
    }
    
    static func LocalToGrpc (timing:CustomerOrganizationTiming) -> Nd_V1_CustomerOrganisationTimingMessage {
        return Nd_V1_CustomerOrganisationTimingMessage.with {
            $0.organisationTimingID = timing.organisationTimingId.toProto
            $0.timingDescription = timing.timingDescription.toProto
            $0.type = timing.type.toProto
        }
    }
    
    static func LocalToGrpc (timings:[CustomerOrganizationTiming]) -> [Nd_V1_CustomerOrganisationTimingMessage] {
        var toReturn = [Nd_V1_CustomerOrganisationTimingMessage]()
        
        for timing in timings {
            toReturn.append(LocalToGrpc(timing: timing))
        }
        
        return toReturn
    }
}
