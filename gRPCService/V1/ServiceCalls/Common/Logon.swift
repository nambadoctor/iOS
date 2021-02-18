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
        let logonClient = Nambadoctor_V1_LogonWorkerV1Client(channel: channel)

        let request = Nambadoctor_V1_LogonRequestMessage.with {
            $0.authToken = AuthTokenId
            $0.deviceToken = FCMTokenId
        }

        let getUserType = logonClient.logon(request, callOptions: callOptions)

        do {
            let response = try getUserType.response.wait()
            print("UserTypeClient received: \(response.userType)")
            let userStatus = CheckLoginStatus.checkStatus(loggedInStatus: response.userType)
            completion(userStatus)
        } catch {
            completion(nil)
            print("UserTypeClient failed: \(error)")
        }

    } 
}
