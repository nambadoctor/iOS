//
//  CustomerDosageMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/21/21.
//

import Foundation

class CustomerDosageMapper {
    static func LocalToGrpc (dosage:CustomerDosage) -> Nd_V1_CustomerDosageMessage {
        return Nd_V1_CustomerDosageMessage.with {
            $0.name = dosage.Name.toProto
            $0.unit = dosage.Unit.toProto
        }
    }

    static func GrpcToLocal (dosage:Nd_V1_CustomerDosageMessage) -> CustomerDosage {
        return CustomerDosage(Name: dosage.name.toString,
                                     Unit: dosage.unit.toString)
    }
}
