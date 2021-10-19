//
//  ServiceProviderCustomerVitalsMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 7/20/21.
//

import Foundation

class ServiceProviderCustomerVitalsMapper {
    static func GrpcToLocal (vital:Nd_V1_ServiceProviderCustomerVitalsMessage) -> ServiceProviderCustomerVitals {
        return ServiceProviderCustomerVitals(BloodPressure: vital.bloodPressure.toString,
                                             BloodSugar: vital.bloodSugar.toString,
                                             Height: vital.height.toString,
                                             Weight: vital.weight.toString,
                                             MenstrualHistory: vital.menstrualHistory.toString,
                                             ObstetricHistory: vital.obstetricHistory.toString,
                                             IsSmoker: vital.isSmoker.toBool,
                                             IsAlcoholConsumer: vital.isAlcoholConsumer.toBool,
                                             Pulse: vital.pulse.toString,
                                             RespiratoryRate: vital.respiratoryRate.toString,
                                             Temperature: vital.temperature.toString,
                                             Saturation: vital.saturation.toString)
    }
    
    static func LocalToGrpc (vital:ServiceProviderCustomerVitals) -> Nd_V1_ServiceProviderCustomerVitalsMessage {
        return Nd_V1_ServiceProviderCustomerVitalsMessage.with {
            $0.bloodPressure = vital.BloodPressure.toProto
            $0.bloodSugar = vital.BloodSugar.toProto
            $0.height = vital.Height.toProto
            $0.weight = vital.Weight.toProto
            $0.menstrualHistory = vital.MenstrualHistory.toProto
            $0.obstetricHistory = vital.ObstetricHistory.toProto
            $0.isSmoker = vital.IsSmoker.toProto
            $0.isAlcoholConsumer = vital.IsAlcoholConsumer.toProto
            $0.pulse = vital.Pulse.toProto
            $0.respiratoryRate = vital.RespiratoryRate.toProto
            $0.temperature = vital.Temperature.toProto
            $0.saturation = vital.Saturation.toProto
        }
    }
}
