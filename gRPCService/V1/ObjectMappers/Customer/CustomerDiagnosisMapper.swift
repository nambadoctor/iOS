//
//  CustomerDiagnosisMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/27/21.
//

import Foundation

class CustomerDiagnosisMapper {
    static func grpcDiagnosisToLocal (diagnosis:Nd_V1_CustomerDiagnosisMessage) -> CustomerDiagnosis {
        return CustomerDiagnosis(
            name: diagnosis.name.toString,
            type: diagnosis.type.toString)
    }
    
    static func localDiagnosisToGrpc (diagnosis:CustomerDiagnosis) -> Nd_V1_CustomerDiagnosisMessage {
        return Nd_V1_CustomerDiagnosisMessage.with {
            $0.name = diagnosis.name.toProto
            $0.type = diagnosis.type.toProto
        }
    }
}
