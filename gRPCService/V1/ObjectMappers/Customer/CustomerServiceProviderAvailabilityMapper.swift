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
            availabilityConfigID: availability.availabilityConfigID.toString,
            paymentType: availability.paymentType.toString,
            organisationId: availability.organisationID.toString,
            addressId: availability.addressID.toString,
            serviceFees: availability.serviceFees.toDouble,
            isOrganisationSlot: availability.isOrganisationSlot.toBool)
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
            $0.paymentType = availability.paymentType.toProto
            $0.organisationID = availability.organisationId.toProto
            $0.addressID = availability.addressId.toProto
            $0.serviceFees = availability.serviceFees.toProto
            $0.isOrganisationSlot = availability.isOrganisationSlot.toProto
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
