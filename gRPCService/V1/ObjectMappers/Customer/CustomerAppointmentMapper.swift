//
//  CustomerAppointmentMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/26/21.
//

import Foundation

class CustomerAppointmentMapper {
    func grpcAppointmentToLocal (appointment:Nd_V1_CustomerAppointmentMessage) -> CustomerAppointment {
        return CustomerAppointment(
            appointmentID: appointment.appointmentID.toString,
            serviceRequestID: appointment.serviceRequestID.toString,
            parentAppointmentID: appointment.parentAppointmentID.toString,
            customerID: appointment.customerID.toString,
            serviceProviderID: appointment.serviceProviderID.toString,
            requestedBy: appointment.requestedBy.toString,
            serviceProviderName: appointment.serviceProviderName.toString,
            customerName: appointment.customerName.toString,
            isBlockedByServiceProvider: appointment.isBlockedByServiceProvider.toBool,
            status: appointment.status.toString,
            serviceFee: appointment.serviceFee.toDouble,
            followUpDays: appointment.followUpDays.toInt32,
            isPaid: appointment.isPaid.toBool,
            scheduledAppointmentStartTime: appointment.scheduledAppointmentStartTime.toInt64,
            scheduledAppointmentEndTime: appointment.scheduledAppointmentEndTime.toInt64,
            actualAppointmentStartTime: appointment.actualAppointmentStartTime.toInt64,
            actualAppointmentEndTime: appointment.actualAppointmentEndTime.toInt64,
            createdDateTime: appointment.createdDateTime.toInt64,
            lastModifiedDate: appointment.lastModifedDate.toInt64,
            noOfReports: appointment.noOfReports.toInt32,
            cancellation: CustomerCancellationMapper.grpcCancellationToLocal(cancellation: appointment.cancellation),
            childId: appointment.childID.toString,
            paymentType: appointment.paymentType.toString,
            appointmentVerification: CustomerAppointmentVerificationMapper().GrpcToLocal(appointmentVerification: appointment.appointmentVerification),
            organisationId: appointment.organisationID.toString,
            organisationName: appointment.organisationName.toString,
            IsInPersonAppointment: appointment.isInPersonAppointment.toBool,
            AddressId: appointment.addressID.toString,
            AppointmentTransfer: CustomerAppointmentTransferMapper.grpcToLocal(transfer: appointment.appointmentTransfer))
    }

    func grpcAppointmentToLocal (appointment:[Nd_V1_CustomerAppointmentMessage]) -> [CustomerAppointment] {
        var appointmentList:[CustomerAppointment] = [CustomerAppointment]()
        
        for app in appointment {
            appointmentList.append(grpcAppointmentToLocal(appointment: app))
        }
        
        return appointmentList
    }
    
    func localAppointmentToGrpc (appointment:CustomerAppointment) -> Nd_V1_CustomerAppointmentMessage {
        return Nd_V1_CustomerAppointmentMessage.with {
            $0.appointmentID = appointment.appointmentID.toProto
            $0.serviceRequestID = appointment.serviceRequestID.toProto
            $0.parentAppointmentID = appointment.parentAppointmentID.toProto
            $0.customerID = appointment.customerID.toProto
            $0.serviceProviderID = appointment.serviceProviderID.toProto
            $0.requestedBy = appointment.requestedBy.toProto
            $0.serviceProviderName = appointment.serviceProviderName.toProto
            $0.customerName = appointment.customerName.toProto
            $0.isBlockedByServiceProvider = appointment.isBlockedByServiceProvider.toProto
            $0.status = appointment.status.toProto
            $0.serviceFee = appointment.serviceFee.toProto
            $0.followUpDays = appointment.followUpDays.toProto
            $0.isPaid = appointment.isPaid.toProto
            $0.scheduledAppointmentStartTime = appointment.scheduledAppointmentStartTime.toProto
            $0.scheduledAppointmentEndTime = appointment.scheduledAppointmentEndTime.toProto
            $0.actualAppointmentStartTime = appointment.actualAppointmentStartTime.toProto
            $0.actualAppointmentEndTime = appointment.actualAppointmentEndTime.toProto
            $0.createdDateTime = appointment.createdDateTime.toProto
            $0.lastModifedDate = appointment.lastModifiedDate.toProto
            $0.noOfReports = appointment.noOfReports.toProto
            $0.cancellation = CustomerCancellationMapper.localCancellationToGrpc(cancellation: appointment.cancellation)
            $0.childID = appointment.childId.toProto
            $0.paymentType = appointment.paymentType.toProto
            if appointment.appointmentVerification != nil {$0.appointmentVerification = CustomerAppointmentVerificationMapper().LocalToGrpc(appointmentVerification: appointment.appointmentVerification!)}
            $0.organisationID = appointment.organisationId.toProto
            $0.organisationName = appointment.organisationName.toProto
            $0.isInPersonAppointment = appointment.IsInPersonAppointment.toProto
            $0.addressID = appointment.AddressId.toProto
            if appointment.AppointmentTransfer != nil {
                $0.appointmentTransfer = CustomerAppointmentTransferMapper.localToGrpc(transfer: appointment.AppointmentTransfer!)
            }
        }
    }

}
