//
//  ServiceProviderGeneratedSlotMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 17/03/21.
//

import Foundation

class ServiceProviderGeneratedSlotMapper {
    static func grpcSlotToLocal(slot:Nd_V1_ServiceProviderGeneratedSlotMessage) -> ServiceProviderGeneratedSlot {
        return ServiceProviderGeneratedSlot(
            startDateTime: slot.startDateTime.toInt64,
            endStartDateTime: slot.endStartDateTime.toInt64,
            duration: slot.duration.toInt32,
            paymentType: slot.paymentType.toString)
    }
    
    static func localSlotToGrpc(slot: ServiceProviderGeneratedSlot) -> Nd_V1_ServiceProviderGeneratedSlotMessage {
        return Nd_V1_ServiceProviderGeneratedSlotMessage.with {
            $0.startDateTime = slot.startDateTime.toProto
            $0.endStartDateTime = slot.endStartDateTime.toProto
            $0.duration = slot.duration.toProto
            $0.paymentType = slot.paymentType.toProto
        }
    }
}
