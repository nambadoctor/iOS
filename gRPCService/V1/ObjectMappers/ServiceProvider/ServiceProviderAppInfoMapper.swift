//
//  ServiceProviderAppInfoMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 17/03/21.
//

import Foundation

class ServiceProviderAppInfoMapper {
    static func grpcAppInfoToLocal(appInfo:Nd_V1_ServiceProviderAppInfo) -> ServiceProviderAppInfo {
        return ServiceProviderAppInfo(authID: appInfo.authID.toString,
                                      authType: appInfo.authType.toString,
                                      deviceToken: appInfo.deviceToken.toString,
                                      appInfoID: appInfo.appInfoID.toString)
    }
    
    static func localAppInfoToGrpc(appInfo:ServiceProviderAppInfo) -> Nd_V1_ServiceProviderAppInfo {
        return Nd_V1_ServiceProviderAppInfo.with {
            $0.authID = appInfo.authID.toProto
            $0.authType = appInfo.authType.toProto
            $0.deviceToken = appInfo.deviceToken.toProto
            $0.appInfoID = appInfo.appInfoID.toProto
        }
    }
}
