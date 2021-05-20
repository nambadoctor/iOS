//
//  ServiceProviderAppointmentObjectMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 17/03/21.
//

import Foundation

class ServiceProviderAppointmentObjectMapper {
    func grpcAppointmentToLocal (appointment:Nd_V1_ServiceProviderAppointmentMessage) -> ServiceProviderAppointment {
        return ServiceProviderAppointment(
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
            cancellation: ServiceProviderCancellationMapper.grpcCancellationToLocal(cancellation: appointment.cancellation))
    }
    
    func grpcAppointmentToLocal (appointment:[Nd_V1_ServiceProviderAppointmentMessage]) -> [ServiceProviderAppointment] {
        var appointmentList:[ServiceProviderAppointment] = [ServiceProviderAppointment]()
        
        for app in appointment {
            appointmentList.append(grpcAppointmentToLocal(appointment: app))
        }
        
        return appointmentList
    }
    
    func localAppointmentToGrpc (appointment:ServiceProviderAppointment) -> Nd_V1_ServiceProviderAppointmentMessage {
        return Nd_V1_ServiceProviderAppointmentMessage.with {
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
            $0.cancellation = ServiceProviderCancellationMapper.localCancellationToGrpc(cancellation: appointment.cancellation)
        }
    }
}
