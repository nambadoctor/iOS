//
//  ApnPayloadDecoder.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 6/4/21.
//

import Foundation
import UIKit

enum APNPayloadKeys : String{
    case aps
    case alert
    case body
    case title
    case type
    case id
}

class ApnPayloadDecoder {
    func getValuesFromAPNPayload (userInfo:[AnyHashable: Any]) -> [String:String] {
        if let apnData = userInfo[AnyHashable(APNPayloadKeys.aps.rawValue)] as? NSDictionary {
            let alertData  = apnData[APNPayloadKeys.alert.rawValue] as! NSDictionary

            let body = alertData[APNPayloadKeys.body.rawValue] as! String
            let title = alertData[APNPayloadKeys.title.rawValue] as! String
            let type = alertData[APNPayloadKeys.type.rawValue] as! String
            let id = alertData[APNPayloadKeys.id.rawValue] as! String

            let returnDict:[String:String] = [APNPayloadKeys.body.rawValue:body,
                                              APNPayloadKeys.title.rawValue:title,
                                              APNPayloadKeys.type.rawValue:type,
                                              APNPayloadKeys.id.rawValue:id]

            return returnDict
        } else {
            let returnDict:[String:String] = [APNPayloadKeys.body.rawValue:"",
                                              APNPayloadKeys.title.rawValue:"",
                                              APNPayloadKeys.type.rawValue:"",
                                              APNPayloadKeys.id.rawValue:""]

            return returnDict
        }
    }
}
