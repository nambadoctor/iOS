//
//  FindDocOrPatientVM.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 17/01/21.
//

import Foundation
import SwiftUI

class Logon : FindUserTypeViewModelProtocol {

    func logonUser (phoneNumber: Nd_V1_CustomerPhoneNumber, _ completion : @escaping (_ patientOrDoc:UserLoginStatus?)->()) {
        
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()

        // Provide the connection to the generated client.
        let logonClient = Nd_V1_UserTypeWorkerV1Client(channel: channel)

        let request = Nd_V1_UserTypeRequest.with {
            $0.authID = AuthTokenId.toProto
            $0.phoneNumber = phoneNumber
        }

        let getUserType = logonClient.getUserType(request, callOptions: callOptions)

        do {
            let response = try getUserType.response.wait()
            print("UserTypeClient received: \(response.message)")
            let userStatus = CheckLoginStatus.checkStatus(loggedInStatus: response.message.toString)
            completion(userStatus)
        } catch {
            completion(nil)
            print("UserTypeClient failed: \(error)")
        }

    } 
}
