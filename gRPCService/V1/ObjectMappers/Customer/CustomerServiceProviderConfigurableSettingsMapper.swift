//
//  CustomerServiceProviderConfigurableSettingsMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 8/10/21.
//

import Foundation

class CustomerServiceProviderConfigurableSettingsMapper {
    static func localToGrpc (setting:CustomerServiceProviderConfigurableSettings) -> Nd_V1_CustomerServiceProviderConfigurableSettingsMessage {
        return Nd_V1_CustomerServiceProviderConfigurableSettingsMessage.with {
            $0.skipFraudPrevention = setting.SkipFraudPrevention.toProto
            $0.dontShowFees = setting.DontShowFees.toProto
        }
    }
    
    static func grpcToLocal (setting:Nd_V1_CustomerServiceProviderConfigurableSettingsMessage) -> CustomerServiceProviderConfigurableSettings {
        return CustomerServiceProviderConfigurableSettings(SkipFraudPrevention: setting.skipFraudPrevention.toBool,
                                                   DontShowFees: setting.dontShowFees.toBool)
    }
}
