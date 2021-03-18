//
//  ServiceProviderServiceRequestMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 17/03/21.
//

import Foundation

class ServiceProviderServiceRequestMapper {
    static func grpcServiceRequestToLocal(serviceRequest:Nd_V1_ServiceProviderServiceRequestMessage) -> ServiceProviderServiceRequest {
        return ServiceProviderServiceRequest(
            serviceRequestID: serviceRequest.serviceRequestID.toString,
            reason: serviceRequest.reason.toString,
            serviceProviderID: serviceRequest.serviceProviderID.toString,
            appointmentID: serviceRequest.appointmentID.toString,
            examination: serviceRequest.examination.toString,
            diagnosis: ServiceProviderDiagnosisObjectMapper.grpcDiagnosisToLocal(diagnosis: serviceRequest.diagnosis),
            investigations: serviceRequest.investigations.convert(),
            advice: serviceRequest.advice.toString,
            createdDateTime: serviceRequest.createdDateTime.toInt64,
            lastModifiedDate: serviceRequest.lastModifedDate.toInt64,
            customerID: serviceRequest.customerID.toString)
    }
    
    static func localServiceRequestToGrpc(serviceRequest:ServiceProviderServiceRequest) -> Nd_V1_ServiceProviderServiceRequestMessage {
        return Nd_V1_ServiceProviderServiceRequestMessage.with{
            $0.serviceRequestID = serviceRequest.serviceRequestID.toProto
            $0.reason = serviceRequest.reason.toProto
            $0.serviceProviderID = serviceRequest.serviceProviderID.toProto
            $0.appointmentID = serviceRequest.appointmentID.toProto
            $0.examination = serviceRequest.examination.toProto
            $0.diagnosis = ServiceProviderDiagnosisObjectMapper.localDiagnosisToGrpc(diagnosis: serviceRequest.diagnosis)
            $0.investigations = serviceRequest.investigations.convert()
            $0.advice = serviceRequest.advice.toProto
            $0.createdDateTime = serviceRequest.createdDateTime.toProto
            $0.lastModifedDate = serviceRequest.lastModifiedDate.toProto
            $0.customerID = serviceRequest.customerID.toProto
        }
    }
}
