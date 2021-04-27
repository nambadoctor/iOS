//
//  CustomerFollowUpMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/26/21.
//

import Foundation

class CustomerFollowUpMapper {
    static func grpcFollowUpToLocal(followUp:Nd_V1_CustomerFollowUpMessage) -> CustomerFollowUp {
        return CustomerFollowUp(
            createdDateTime: followUp.createdDateTime.toInt64,
            noOfDays: followUp.noOfDays.toInt32,
            followUpFee: followUp.followUpFee.toDouble)
    }
    
    static func localFollowUpToGrpc(followUp:CustomerFollowUp) -> Nd_V1_CustomerFollowUpMessage {
        return Nd_V1_CustomerFollowUpMessage.with {
            $0.createdDateTime = followUp.createdDateTime.toProto
            $0.noOfDays = followUp.noOfDays.toProto
            $0.followUpFee = followUp.followUpFee.toProto
        }
    }

}
