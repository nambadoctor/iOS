//
//  CustomerVitalsMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 7/20/21.
//

import Foundation

class CustomerVitalsMapper {
    static func GrpcToLocal (vital:Nd_V1_CustomerVitalsMessage) -> CustomerVitals {
        return CustomerVitals(BloodPressure: vital.bloodPressure.toString,
                                             BloodSugar: vital.bloodSugar.toString,
                                             Height: vital.height.toString,
                                             Weight: vital.weight.toString,
                                             MenstrualHistory: vital.menstrualHistory.toString,
                                             ObstetricHistory: vital.obstetricHistory.toString,
                                             IsSmoker: vital.isSmoker.toBool,
                                             IsAlcoholConsumer: vital.isAlcoholConsumer.toBool)
    }
    
    static func LocalToGrpc (vital:CustomerVitals) -> Nd_V1_CustomerVitalsMessage {
        return Nd_V1_CustomerVitalsMessage.with {
            $0.bloodPressure = vital.BloodPressure.toProto
            $0.bloodSugar = vital.BloodSugar.toProto
            $0.height = vital.Height.toProto
            $0.weight = vital.Weight.toProto
            $0.menstrualHistory = vital.MenstrualHistory.toProto
            $0.obstetricHistory = vital.ObstetricHistory.toProto
            $0.isSmoker = vital.IsSmoker.toProto
            $0.isAlcoholConsumer = vital.IsAlcoholConsumer.toProto
        }
    }
}

