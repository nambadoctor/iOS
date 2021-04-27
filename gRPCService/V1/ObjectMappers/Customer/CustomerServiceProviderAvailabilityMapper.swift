//
//  CustomerServiceProviderAvailabilityMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/26/21.
//

import Foundation

class CustomerServiceProviderAvailabilityMapper {
    static func grpcAvailabilityToLocal (availability:Nd_V1_CustomerServiceProviderAvailability) -> CustomerServiceProviderAvailability {
        return CustomerServiceProviderAvailability(
            dayOfWeek: availability.dayOfWeek.toInt32,
            startTime: availability.startTime.toInt64,
            endTime: availability.endTime.toInt64,
            availabilityConfigID: availability.availabilityConfigID.toString)
    }
    
    static func grpcAvailabilityToLocal (availability:[Nd_V1_CustomerServiceProviderAvailability]) -> [CustomerServiceProviderAvailability] {
        var availabilityList:[CustomerServiceProviderAvailability] = [CustomerServiceProviderAvailability]()
        
        for avail in availability {
            availabilityList.append(grpcAvailabilityToLocal(availability: avail))
        }
        
        return availabilityList
    }
    
    static func localAvailabilityToGrpc (availability:CustomerServiceProviderAvailability) -> Nd_V1_CustomerServiceProviderAvailability {
        
        return Nd_V1_CustomerServiceProviderAvailability.with {
            $0.dayOfWeek = availability.dayOfWeek.toProto
            $0.startTime = availability.startTime.toProto
            $0.endTime = availability.endTime.toProto
            $0.availabilityConfigID = availability.availabilityConfigID.toProto
        }
    }
    
    static func localAvailabilityToGrpc (availability:[CustomerServiceProviderAvailability]) -> [Nd_V1_CustomerServiceProviderAvailability] {
        var availabilityList:[Nd_V1_CustomerServiceProviderAvailability] = [Nd_V1_CustomerServiceProviderAvailability]()
        
        for avail in availability {
            availabilityList.append(localAvailabilityToGrpc(availability: avail))
        }
        
        return availabilityList
    }

}
