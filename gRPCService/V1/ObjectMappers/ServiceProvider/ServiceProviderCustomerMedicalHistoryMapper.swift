//
//  ServiceProviderCustomerMedicalHistoryMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/8/21.
//

import Foundation

class ServiceProviderCustomerMedicalHistoryMapper {
    static func localMedicalHistoryToGrpc(medicalHistory:ServiceProviderCustomerMedicalHistory) -> Nd_V1_ServiceProviderMedicalHistoryMessage {
        return Nd_V1_ServiceProviderMedicalHistoryMessage.with {
            $0.medicalHistoryID = medicalHistory.MedicalHistoryId.toProto
            $0.medicalHistoryName = medicalHistory.MedicalHistoryName.toProto
            $0.pastMedicalHistory = medicalHistory.PastMedicalHistory.toProto
            $0.medicationHistory = medicalHistory.MedicationHistory.toProto
            $0.appointmentID = medicalHistory.AppointmentId.toProto
            $0.serviceRequestID = medicalHistory.ServiceRequestId.toProto
        }
    }

    static func grpcMedicalHistoryToLocal (medicalHistoryMessage:Nd_V1_ServiceProviderMedicalHistoryMessage) -> ServiceProviderCustomerMedicalHistory {
        return ServiceProviderCustomerMedicalHistory(MedicalHistoryId: medicalHistoryMessage.medicalHistoryID.toString,
                                                     MedicalHistoryName: medicalHistoryMessage.medicalHistoryName.toString,
                                                     PastMedicalHistory: medicalHistoryMessage.pastMedicalHistory.toString,
                                                     MedicationHistory: medicalHistoryMessage.medicationHistory.toString,
                                                     AppointmentId: medicalHistoryMessage.appointmentID.toString,
                                                     ServiceRequestId: medicalHistoryMessage.serviceRequestID.toString)
    }
}
