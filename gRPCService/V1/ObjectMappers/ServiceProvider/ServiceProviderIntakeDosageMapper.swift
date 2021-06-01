//
//  ServiceProviderIntakeDosageMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/30/21.
//

import Foundation

class ServiceProviderIntakeDosageMapper {
    static func LocalToGrpc (dosage:ServiceProviderIntakeDosage) -> Nd_V1_ServiceProviderIntakeDosageMessage {
        return Nd_V1_ServiceProviderIntakeDosageMessage.with {
            $0.name = dosage.Name.toProto
            $0.unit = dosage.Unit.toProto
        }
    }

    static func GrpcToLocal (dosage:Nd_V1_ServiceProviderIntakeDosageMessage) -> ServiceProviderIntakeDosage {
        return ServiceProviderIntakeDosage(Name: dosage.name.toString,
                                     Unit: dosage.unit.toString)
    }
}
