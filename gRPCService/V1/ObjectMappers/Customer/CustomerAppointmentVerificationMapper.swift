//
//  CustomerAppointmentVerificationMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 7/6/21.
//

import Foundation

class CustomerAppointmentVerificationMapper {
    func LocalToGrpc (appointmentVerification:CustomerAppointmentVerification) -> Nd_V1_CustomerAppointmentVerificationMessage{
        return Nd_V1_CustomerAppointmentVerificationMessage.with {
            $0.appointmentVerificationID = appointmentVerification.AppointmentVerificationId.toProto
            $0.verificationStatus = appointmentVerification.VerificationStatus.toProto
            $0.verifiedBy = appointmentVerification.VerifiedBy.toProto
            if (appointmentVerification.VerifiedTime != nil && appointmentVerification.VerifiedTime != 0) {$0.verifiedTime = appointmentVerification.VerifiedTime!.toProto}
            $0.customerResponseForReason = appointmentVerification.CustomerResponseForReason.toProto
        }
    }
    
    func GrpcToLocal (appointmentVerification:Nd_V1_CustomerAppointmentVerificationMessage) -> CustomerAppointmentVerification {
        return CustomerAppointmentVerification(AppointmentVerificationId: appointmentVerification.appointmentVerificationID.toString,
                                               VerificationStatus: appointmentVerification.verificationStatus.toString,
                                               VerifiedBy: appointmentVerification.verifiedBy.toString,
                                               VerifiedTime: appointmentVerification.verifiedTime.toInt64,
                                               CustomerResponseForReason: appointmentVerification.customerResponseForReason.toString)
    }
}
