//
//  CustomerDurationMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/21/21.
//

import Foundation

class CustomerDurationMapper {
    static func LocalToGrpc (duration:CustomerDuration) -> Nd_V1_CustomerDurationMessage {
        return Nd_V1_CustomerDurationMessage.with {
            $0.days = duration.Days.toProto
            $0.unit = duration.Unit.toProto
        }
    }

    static func GrpcToLocal (duration:Nd_V1_CustomerDurationMessage) -> CustomerDuration {
        return CustomerDuration(Days: duration.days.toString,
                                     Unit: duration.unit.toString)
    }
}
