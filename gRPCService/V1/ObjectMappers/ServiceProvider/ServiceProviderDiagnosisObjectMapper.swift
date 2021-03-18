//
//  ServiceProviderDiagnosisObjectMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 17/03/21.
//

import Foundation

class ServiceProviderDiagnosisObjectMapper {
    static func grpcDiagnosisToLocal (diagnosis:Nd_V1_ServiceProviderDiagnosisMessage) -> ServiceProviderDiagnosis {
        return ServiceProviderDiagnosis(
            name: diagnosis.name.toString,
            type: diagnosis.type.toString)
    }
    
    static func localDiagnosisToGrpc (diagnosis:ServiceProviderDiagnosis) -> Nd_V1_ServiceProviderDiagnosisMessage {
        return Nd_V1_ServiceProviderDiagnosisMessage.with {
            $0.name = diagnosis.name.toProto
            $0.type = diagnosis.type.toProto
        }
    }
}
