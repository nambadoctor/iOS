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

        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()

        // Provide the connection to the generated client.
        let logonClient = Nd_V1_UserTypeWorkerV1Client(channel: channel)
                
        let request = Nd_V1_VoidMessage.with { _ in }

        let getUserType = logonClient.getUserType(request, callOptions: callOptions)

        do {
            let response = try getUserType.response.wait()
            print("UserTypeClient received: \(response.message.toString)")
            let responseSplit = response.message.toString.components(separatedBy: ",")
            if responseSplit.count > 1 {
                let userStatus = CheckLoginStatus.checkStatus(loggedInStatus: responseSplit[0])
                UserIdHelper().storeUserId(userId: responseSplit[1])
                completion(userStatus)
            } else {
                completion(.Customer)
            }
        } catch {
            completion(nil)
            print("UserTypeClient failed: \(error.localizedDescription)")
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
