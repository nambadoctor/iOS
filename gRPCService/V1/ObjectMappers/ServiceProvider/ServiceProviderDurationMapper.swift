//
//  ServiceProviderDurationMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/20/21.
//

import Foundation

class ServiceProviderDurationMapper {
    static func LocalToGrpc (duration:ServiceProviderDuration) -> Nd_V1_ServiceProviderDurationMessage {
        return Nd_V1_ServiceProviderDurationMessage.with {
            $0.days = duration.Days.toProto
            $0.unit = duration.Unit.toProto
        }
    }

    static func GrpcToLocal (duration:Nd_V1_ServiceProviderDurationMessage) -> ServiceProviderDuration {
        return ServiceProviderDuration(Days: duration.days.toString,
                                     Unit: duration.unit.toString)
    }
}
