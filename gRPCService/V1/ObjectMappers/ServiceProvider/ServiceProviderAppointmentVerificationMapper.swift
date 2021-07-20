//
//  ServiceProviderAppointmentVerificationMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 7/20/21.
//

import Foundation

class ServiceProviderAppointmentVerificationMapper {
    func LocalToGrpc (appointmentVerification:ServiceProviderAppointmentVerification) -> Nd_V1_ServiceProviderAppointmentVerificationMessage{
        return Nd_V1_ServiceProviderAppointmentVerificationMessage.with {
            $0.appointmentVerificationID = appointmentVerification.AppointmentVerificationId.toProto
            $0.verificationStatus = appointmentVerification.VerificationStatus.toProto
            $0.verifiedBy = appointmentVerification.VerifiedBy.toProto
            if (appointmentVerification.VerifiedTime != nil && appointmentVerification.VerifiedTime != 0) {$0.verifiedTime = appointmentVerification.VerifiedTime!.toProto}
            $0.customerResponseForReason = appointmentVerification.CustomerResponseForReason.toProto
        }
    }
    
    func GrpcToLocal (appointmentVerification:Nd_V1_ServiceProviderAppointmentVerificationMessage) -> ServiceProviderAppointmentVerification {
        return ServiceProviderAppointmentVerification(AppointmentVerificationId: appointmentVerification.appointmentVerificationID.toString,
                                               VerificationStatus: appointmentVerification.verificationStatus.toString,
                                               VerifiedBy: appointmentVerification.verifiedBy.toString,
                                               VerifiedTime: appointmentVerification.verifiedTime.toInt64,
                                               CustomerResponseForReason: appointmentVerification.customerResponseForReason.toString)
    }
}
