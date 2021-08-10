//
//  ServiceProviderConfigurableSettingsMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 8/10/21.
//

import Foundation

class ServiceProviderConfigurableSettingsMapper {
    static func localToGrpc (setting:ServiceProviderConfigurableSettings) -> Nd_V1_ServiceProviderConfigurableSettingsMessage {
        return Nd_V1_ServiceProviderConfigurableSettingsMessage.with {
            $0.skipFraudPrevention = setting.SkipFraudPrevention.toProto
            $0.dontShowFees = setting.DontShowFees.toProto
        }
    }
    
    static func grpcToLocal (setting:Nd_V1_ServiceProviderConfigurableSettingsMessage) -> ServiceProviderConfigurableSettings {
        return ServiceProviderConfigurableSettings(SkipFraudPrevention: setting.skipFraudPrevention.toBool,
                                                   DontShowFees: setting.dontShowFees.toBool)
    }
}
