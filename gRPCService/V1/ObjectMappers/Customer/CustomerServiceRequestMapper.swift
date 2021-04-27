//
//  CustomerServiceRequestMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/27/21.
//

import Foundation

class CustomerServiceRequestMapper {
    func grpcServiceRequestToLocal(serviceRequest:Nd_V1_CustomerServiceRequestMessage) -> CustomerServiceRequest {
        return CustomerServiceRequest(
            serviceRequestID: serviceRequest.serviceRequestID.toString,
            reason: serviceRequest.reason.toString,
            serviceProviderID: serviceRequest.serviceProviderID.toString,
            appointmentID: serviceRequest.appointmentID.toString,
            examination: serviceRequest.examination.toString,
            diagnosis: CustomerDiagnosisMapper.grpcDiagnosisToLocal(diagnosis: serviceRequest.diagnosis),
            investigations: serviceRequest.investigations.convert(),
            advice: serviceRequest.advice.toString,
            createdDateTime: serviceRequest.createdDateTime.toInt64,
            lastModifiedDate: serviceRequest.lastModifedDate.toInt64,
            customerID: serviceRequest.customerID.toString,
            allergy: CustomerAllergyMapper.grpcAllergyToLocal(allergyMessage: serviceRequest.allergy),
            medicalHistory: CustomerMedicalHistoryMapper.grpcMedicalHistoryToLocal(medicalHistoryMessage: serviceRequest.medicalHistory))
    }

    func localServiceRequestToGrpc(serviceRequest:CustomerServiceRequest) -> Nd_V1_CustomerServiceRequestMessage {
        return Nd_V1_CustomerServiceRequestMessage.with{
            $0.serviceRequestID =  serviceRequest.serviceRequestID.toProto
            $0.reason = serviceRequest.reason.toProto
            $0.serviceProviderID = serviceRequest.serviceProviderID.toProto
            $0.appointmentID = serviceRequest.appointmentID.toProto
            $0.examination = serviceRequest.examination.toProto
            $0.diagnosis = CustomerDiagnosisMapper.localDiagnosisToGrpc(diagnosis: serviceRequest.diagnosis)
            $0.investigations = serviceRequest.investigations.convert()
            $0.advice = serviceRequest.advice.toProto
            $0.createdDateTime = serviceRequest.createdDateTime.toProto
            $0.lastModifedDate = serviceRequest.lastModifiedDate.toProto
            $0.customerID = serviceRequest.customerID.toProto
            $0.allergy = CustomerAllergyMapper.localAllergyToGrpc(allergy: serviceRequest.allergy)
            $0.medicalHistory = CustomerMedicalHistoryMapper.localMedicalHistoryToGrpc(medicalHistory: serviceRequest.medicalHistory)
        }
    }

}
