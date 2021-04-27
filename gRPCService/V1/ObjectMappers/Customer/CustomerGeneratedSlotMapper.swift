//
//  CustomerGeneratedSlotMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/26/21.
//

import Foundation

class CustomerGeneratedSlotMapper {
    static func grpcSlotToLocal(slot:Nd_V1_CustomerGeneratedSlotMessage) -> CustomerGeneratedSlot {
        return CustomerGeneratedSlot(
            startDateTime: slot.startDateTime.toInt64,
            endStartDateTime: slot.endStartDateTime.toInt64,
            duration: slot.duration.toInt32)
    }
    
    static func localSlotToGrpc(slot: CustomerGeneratedSlot) -> Nd_V1_CustomerGeneratedSlotMessage {
        return Nd_V1_CustomerGeneratedSlotMessage.with {
            $0.startDateTime = slot.startDateTime.toProto
            $0.endStartDateTime = slot.endStartDateTime.toProto
            $0.duration = slot.duration.toProto
        }
    }
}