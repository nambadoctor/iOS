//
//  CustomerMedicalHistoryMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/26/21.
//

import Foundation

class CustomerMedicalHistoryMapper {
    static func localMedicalHistoryToGrpc(medicalHistory:CustomerMedicalHistory) -> Nd_V1_CustomerMedicalHistoryMessage {
        return Nd_V1_CustomerMedicalHistoryMessage.with {
            $0.medicalHistoryID = medicalHistory.MedicalHistoryId.toProto
            $0.medicalHistoryName = medicalHistory.MedicalHistoryName.toProto
            $0.appointmentID = medicalHistory.AppointmentId.toProto
            $0.serviceRequestID = medicalHistory.ServiceRequestId.toProto
        }
    }
    
    static func localMedicalHistoryToGrpc (medicalHistories:[CustomerMedicalHistory]) -> [Nd_V1_CustomerMedicalHistoryMessage] {
        var medHistoryList:[Nd_V1_CustomerMedicalHistoryMessage] = [Nd_V1_CustomerMedicalHistoryMessage]()
        
        for medHistory in medicalHistories {
            medHistoryList.append(localMedicalHistoryToGrpc(medicalHistory: medHistory))
        }

        return medHistoryList
    }

    
    static func grpcMedicalHistoryToLocal (medicalHistoryMessage:Nd_V1_CustomerMedicalHistoryMessage) -> CustomerMedicalHistory {
        return CustomerMedicalHistory(MedicalHistoryId: medicalHistoryMessage.medicalHistoryID.toString,
                                                     MedicalHistoryName: medicalHistoryMessage.medicalHistoryName.toString,
                                                     AppointmentId: medicalHistoryMessage.appointmentID.toString,
                                                     ServiceRequestId: medicalHistoryMessage.serviceRequestID.toString)
    }
    
    static func grpcMedicalHistoryToLocal (medicalHistories:[Nd_V1_CustomerMedicalHistoryMessage]) -> [CustomerMedicalHistory] {
        var medHistoryList:[CustomerMedicalHistory] = [CustomerMedicalHistory]()
        
        for medHistory in medicalHistories {
            medHistoryList.append(grpcMedicalHistoryToLocal(medicalHistoryMessage: medHistory))
        }
        
        return medHistoryList
    }


}
