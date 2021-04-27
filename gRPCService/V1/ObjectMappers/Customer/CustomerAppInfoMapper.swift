//
//  CustomerAppInfoMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/26/21.
//

import Foundation

class CustomerAppInfoMapper {
    static func grpcAppInfoToLocal(appInfo:Nd_V1_CustomerAppInfo) -> CustomerAppInfo {
        return CustomerAppInfo(authID: appInfo.authID.toString,
                                      authType: appInfo.authType.toString,
                                      deviceToken: appInfo.deviceToken.toString,
                                      appInfoID: appInfo.appInfoID.toString)
    }
    
    static func localAppInfoToGrpc(appInfo:CustomerAppInfo) -> Nd_V1_CustomerAppInfo {
        return Nd_V1_CustomerAppInfo.with {
            $0.authID = appInfo.authID.toProto
            $0.authType = appInfo.authType.toProto
            $0.deviceToken = appInfo.deviceToken.toProto
            $0.appInfoID = appInfo.appInfoID.toProto
        }
    }

}
