//
//  CustomerUpdateHelpers.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 6/16/21.
//

import Foundation

class CustomerUpdateHelpers {
    func UpdateFCMToken (customerId:String, completion: @escaping (_ response:String?)->()) {
        let customer = CustomerProfile(customerID: customerId, appInfo: CustomerAppInfo(authID: "", authType: "", deviceToken: DeviceTokenId, appInfoID: "", deviceTokenType: "apn"))
        
        CustomerProfileService().setCustomerProfile(customerProfile: customer) { response in
            completion(response)
        }
    }
}
