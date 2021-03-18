//
//  ServiceProviderFollowUpMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 17/03/21.
//

import Foundation

class ServiceProviderFollowUpMapper {
    static func grpcFollowUpToLocal(followUp:Nd_V1_ServiceProviderFollowUpMessage) -> ServiceProviderFollowUp {
        return ServiceProviderFollowUp(
            createdDateTime: followUp.createdDateTime.toInt64,
            noOfDays: followUp.noOfDays.toInt32,
            followUpFee: followUp.followUpFee.toDouble)
    }
    
    static func localFollowUpToGrpc(followUp:ServiceProviderFollowUp) -> Nd_V1_ServiceProviderFollowUpMessage {
        return Nd_V1_ServiceProviderFollowUpMessage.with {
            $0.createdDateTime = followUp.createdDateTime.toProto
            $0.noOfDays = followUp.noOfDays.toProto
            $0.followUpFee = followUp.followUpFee.toProto
        }
    }
}
