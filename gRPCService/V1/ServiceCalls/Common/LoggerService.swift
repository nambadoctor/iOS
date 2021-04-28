//
//  LoggerService.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/27/21.
//

import Foundation

var SessionId:String = ""
var CorrelationId:String = ""

class LoggerService {
    func log(appointmentId:String, eventName:String) {
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        let loggerClient = Nd_V1_LoggingWorkerV1Client(channel: channel)
        
        var version = "1.45"
        if let retrievedVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            version = retrievedVersion
            print("Version: \(retrievedVersion)")
        }

        let request = Nd_V1_LogInfoMessage.with {
            $0.userID = UserIdHelper().retrieveUserId().toProto
            $0.userType = GetUserTypeHelper.getUserType().toProto
            $0.eventDateTime = Date().millisecondsSince1970.toProto
            $0.appointmentID = appointmentId.toProto
            $0.sessionID = SessionId.toProto
            $0.correlationID = CorrelationId.toProto
            $0.appVersion = version.toProto
            $0.eventMessage = eventName.toProto
            $0.logLevel = "info".toProto //info/debug/error
            $0.isProduction = true
        }

        let logEvent = loggerClient.setLog(request, callOptions: callOptions)
        
        DispatchQueue.global().async {
            do {
                let response = try logEvent.response.wait()
                print("LoggedEvent received: \(response)")
            } catch {
                print("LoggedEvent failed: \(error.localizedDescription)")
            }
        }
    }
}
