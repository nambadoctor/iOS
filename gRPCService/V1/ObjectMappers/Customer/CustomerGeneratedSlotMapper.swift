//
//  CustomerGeneratedSlotMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/26/21.
//

import Foundation

class CustomerGeneratedSlotMapper {
    func grpcSlotToLocal(slot:Nd_V1_CustomerGeneratedSlotMessage) -> CustomerGeneratedSlot {
        return CustomerGeneratedSlot(
            startDateTime: slot.startDateTime.toInt64,
            endDateTime: slot.endStartDateTime.toInt64,
            duration: slot.duration.toInt32,
            paymentType: slot.paymentType.toString,
            organisationId: slot.organisationID.toString,
            addressId: slot.addressID.toString,
            serviceFees: slot.serviceFees.toDouble,
            isOrganisationSlot: slot.isOrganisationSlot.toBool)
    }
    
    func grpcSlotToLocal (slots:[Nd_V1_CustomerGeneratedSlotMessage]) -> [CustomerGeneratedSlot] {
        var slotList:[CustomerGeneratedSlot] = [CustomerGeneratedSlot]()
        
        for slot in slots {
            if !slotList.contains { $0.startDateTime == slot.startDateTime.toInt64 } {
                slotList.append(grpcSlotToLocal(slot: slot))
            }
        }
        
        return slotList
    }
    
    func localSlotToGrpc(slot: CustomerGeneratedSlot) -> Nd_V1_CustomerGeneratedSlotMessage {
        return Nd_V1_CustomerGeneratedSlotMessage.with {
            $0.startDateTime = slot.startDateTime.toProto
            $0.endStartDateTime = slot.endDateTime.toProto
            $0.duration = slot.duration.toProto
            $0.paymentType = slot.paymentType.toProto
            $0.organisationID = slot.organisationId.toProto
            $0.addressID = slot.addressId.toProto
            $0.serviceFees = slot.serviceFees.toProto
            $0.isOrganisationSlot = slot.isOrganisationSlot.toProto
        }
    }
}
