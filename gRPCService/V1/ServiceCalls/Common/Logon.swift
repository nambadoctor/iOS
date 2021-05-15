//
//  FindDocOrPatientVM.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 17/01/21.
//

import Foundation
import SwiftUI

class Logon : FindUserTypeViewModelProtocol {

    func logonUser (_ completion : @escaping (_ patientOrDoc:UserLoginStatus?)->()) {
        CorrelationId = UUID().uuidString
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()

        // Provide the connection to the generated client.
        let logonClient = Nd_V1_UserTypeWorkerV1Client(channel: channel)
                
        let request = Nd_V1_VoidMessage.with { _ in }

        let getUserType = logonClient.getUserType(request, callOptions: callOptions)

        DispatchQueue.global().async {
            do {
                LoggerService().log(appointmentId: "", eventName: "REQUESTING USER TYPE")
                let response = try getUserType.response.wait()
                LoggerService().log(appointmentId: "", eventName: "RECIEVED USER TYPE SUCCESS")
                print("UserTypeClient received: \(response.message.toString)")
                
                let responseSplit = response.message.toString.components(separatedBy: ",")

                DispatchQueue.main.async {
                    if responseSplit.count > 1 {
                        let userStatus = CheckLoginStatus.checkStatus(loggedInStatus: responseSplit[0])
                        UserIdHelper().storeUserId(userId: responseSplit[1])
                        UserTypeHelper.setUserType(userType: userStatus)
                        completion(userStatus)
                    } else {
                        completion(.NotRegistered)
                    }
                }

            } catch {
                completion(nil)
                print("UserTypeClient failed: \(error.localizedDescription)")
                LoggerService().log(appointmentId: "", eventName: "RECIEVED USER TYPE FAILED")
            }
        }
    }
}

class UserIdHelper {
    func storeUserId(userId:String) {
        let defaults = UserDefaults.standard
        defaults.set(userId, forKey: "userId")
    }

    func retrieveUserId() -> String {
        let defaults = UserDefaults.standard
        if let userId = defaults.string(forKey: "userId") {
            return userId
        } else {
            return "USER ID NOT FOUND"
        }
    }
}

class UserTypeHelper {
    static func getUserType() -> String {
        return UserDefaults.standard.value(forKey: SimpleStateK.userType.rawValue) as? String ?? ""
    }

    static func setUserType (userType:UserLoginStatus) {
        let defaults = UserDefaults.standard
        defaults.set(userType.rawValue, forKey: SimpleStateK.userType.rawValue)
    }
    
    static func checkIfDoctor (userType:String) -> Bool {
        if userType == UserLoginStatus.ServiceProvider.rawValue {
            return true
        } else {
            return false
        }
    }
    
    static func checkIfCustomer (userType:String) -> Bool {
        if userType == UserLoginStatus.Customer.rawValue {
            return true
        } else {
            return false
        }
    }
}
