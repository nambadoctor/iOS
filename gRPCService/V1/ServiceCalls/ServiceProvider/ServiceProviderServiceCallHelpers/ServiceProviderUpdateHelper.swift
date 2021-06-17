//
//  ServiceProviderUpdateHelper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 6/17/21.
//

import Foundation

class ServiceProviderUpdateHelper {
    func UpdateFCMToken (appInfoId:String, serviceProviderId:String, completion: @escaping (_ response:String?)->()) {
        let serviceProvider = ServiceProviderProfile(serviceProviderID: serviceProviderId, applicationInfo: ServiceProviderAppInfo(authID: AuthenticateService().getUserId(), authType: "Firebase", deviceToken: DeviceTokenId, appInfoID: appInfoId, deviceTokenType: "apn"))

        ServiceProviderProfileService().setServiceProvider(serviceProvider: serviceProvider) { response in
            completion(response)
        }
    }
}
