//
//  ServiceProviderAvailaibility.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 17/03/21.
//

import Foundation

class ServiceProviderAvailaibilityObjectMapper {
    static func grpcAvailabilityToLocal (availability:Nd_V1_ServiceProviderAvailability) -> ServiceProviderAvailability {
        return ServiceProviderAvailability(
            dayOfWeek: availability.dayOfWeek.toInt32,
            startTime: availability.startTime.toInt64,
            endTime: availability.endTime.toInt64,
            availabilityConfigID: availability.availabilityConfigID.toString,
            paymentType: availability.paymentType.toString)
    }
    
    static func grpcAvailabilityToLocal (availability:[Nd_V1_ServiceProviderAvailability]) -> [ServiceProviderAvailability] {
        var availabilityList:[ServiceProviderAvailability] = [ServiceProviderAvailability]()
        
        for avail in availability {
            availabilityList.append(grpcAvailabilityToLocal(availability: avail))
        }
        
        return availabilityList
    }

    static func localAvailabilityToGrpc (availability:ServiceProviderAvailability) -> Nd_V1_ServiceProviderAvailability {
        
        return Nd_V1_ServiceProviderAvailability.with {
            $0.dayOfWeek = availability.dayOfWeek.toProto
            $0.startTime = availability.startTime.toProto
            $0.endTime = availability.endTime.toProto
            $0.availabilityConfigID = availability.availabilityConfigID.toProto
            $0.paymentType = availability.paymentType.toProto
        }
    }
    
    static func localAvailabilityToGrpc (availability:[ServiceProviderAvailability]) -> [Nd_V1_ServiceProviderAvailability] {
        var availabilityList:[Nd_V1_ServiceProviderAvailability] = [Nd_V1_ServiceProviderAvailability]()
        
        for avail in availability {
            availabilityList.append(localAvailabilityToGrpc(availability: avail))
        }
        
        return availabilityList
    }
}
