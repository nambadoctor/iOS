//
//  ServiceProviderAppointmentTransferMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 7/25/21.
//

import Foundation

class ServiceProviderAppointmentTransferMapper {
    static func grpcToLocal (transfer:Nd_V1_ServiceProviderAppointmentTransferMessage) -> ServiceProviderAppointmentTransfer {
        return ServiceProviderAppointmentTransfer(AppointmentTransferId: transfer.appointmentTransferID.toString,
                                                  TransferredBy: transfer.transferredBy.toString,
                                                  TransferredTo: transfer.transferredTo.toString,
                                                  TransferReason: transfer.transferReason.toString,
                                                  TransferredTime: transfer.transferredTime.toInt64)
    }
    
    static func localToGrpc (transfer:ServiceProviderAppointmentTransfer) -> Nd_V1_ServiceProviderAppointmentTransferMessage {
        return Nd_V1_ServiceProviderAppointmentTransferMessage.with {
            $0.appointmentTransferID = transfer.AppointmentTransferId.toProto
            $0.transferredBy = transfer.TransferredBy.toProto
            $0.transferredTo = transfer.TransferredTo.toProto
            $0.transferReason = transfer.TransferReason.toProto
            $0.transferredTime = transfer.TransferredTime.toProto
        }
    }
}
