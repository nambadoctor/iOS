//
//  ServiceProviderOrganisationTimingMapperj.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 7/20/21.
//

import Foundation

class ServiceProviderOrganisationTimingMapper {
    static func GrpcToLocal (timing:Nd_V1_ServiceProviderOrganisationTimingMessage) -> ServiceProviderOrganisationTiming {
        return ServiceProviderOrganisationTiming(organisationTimingId: timing.organisationTimingID.toString,
                                                 timingDescription: timing.timingDescription.toString,
                                                 type: timing.type.toString)
    }
    
    static func GrpcToLocal (timings:[Nd_V1_ServiceProviderOrganisationTimingMessage]) -> [ServiceProviderOrganisationTiming] {
        var toReturn = [ServiceProviderOrganisationTiming]()
        
        for timing in timings {
            toReturn.append(GrpcToLocal(timing: timing))
        }
        
        return toReturn
    }
    
    static func LocalToGrpc (timing:ServiceProviderOrganisationTiming) -> Nd_V1_ServiceProviderOrganisationTimingMessage {
        return Nd_V1_ServiceProviderOrganisationTimingMessage.with {
            $0.organisationTimingID = timing.organisationTimingId.toProto
            $0.timingDescription = timing.timingDescription.toProto
            $0.type = timing.type.toProto
        }
    }
    
    static func LocalToGrpc (timings:[ServiceProviderOrganisationTiming]) -> [Nd_V1_ServiceProviderOrganisationTimingMessage] {
        var toReturn = [Nd_V1_ServiceProviderOrganisationTimingMessage]()
        
        for timing in timings {
            toReturn.append(LocalToGrpc(timing: timing))
        }
        
        return toReturn
    }
}
