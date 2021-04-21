//
//  LocalNotifHelper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/21/21.
//

import Foundation


struct LocalNotifObj : Codable {
    var Title:String
    var Body:String
    var NotifType:NotifTypes
    var AppointmentId:String
    var viewed:Bool
    var timeStamp:Int64
}

var localNotifsEncodingString = "localNotifEncodingKey"
class LocalNotifStorer {
    func storeLocalNotif (title:String, body:String, appointmentId:String, notifType:NotifTypes) {
        let localNotifObj:LocalNotifObj = LocalNotifObj(Title: title, Body: body, NotifType: notifType, AppointmentId: appointmentId, viewed: false, timeStamp: Date().millisecondsSince1970)

        var notifs = LocalDecoder.decode(modelType: [LocalNotifObj].self, from: localNotifsEncodingString)
        if notifs != nil {
            notifs?.append(localNotifObj)
            LocalEncoder.encode(payload: notifs, destination: localNotifsEncodingString)
        } else {
            let notifArr:[LocalNotifObj] = [localNotifObj]
            LocalEncoder.encode(payload: notifArr, destination: localNotifsEncodingString)
        }
    }

    func getLocalNotifs () -> [LocalNotifObj]? {
        let notifs = LocalDecoder.decode(modelType: [LocalNotifObj].self, from: localNotifsEncodingString)
        
        if notifs != nil {
            return notifs!.reversed()
        } else {
            return nil
        }
    }
}
