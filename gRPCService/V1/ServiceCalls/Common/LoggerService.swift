//
//  LoggerService.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/27/21.
//

import Foundation

var SessionId:String = ""
var CorrelationId:String = ""
var AppointmentID:String = ""
var EventMessage:String = ""
var VersionNumber:String = "1.54"

class LoggerService {
    func log(appointmentId:String, eventName:String) {
        
        AppointmentID = appointmentId
        EventMessage = eventName

        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        let loggerClient = Nd_V1_LoggingWorkerV1Client(channel: channel)

        let request = Nd_V1_VoidMessage()

        let logEvent = loggerClient.setLog(request, callOptions: callOptions)

        DispatchQueue.global().async {
            do {
                let response = try logEvent.response.wait()
                print("LoggedEvent received: \(response.status) \(EventMessage)")
            } catch {
                print("LoggedEvent failed: \(error.localizedDescription)")
            }
        }
    }
}
