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
        var localNotifObj:LocalNotifObj = LocalNotifObj(Title: title, Body: body, NotifType: notifType, AppointmentId: appointmentId, viewed: false, timeStamp: Date().millisecondsSince1970)
        
        var notifs = LocalDecoder.decode(modelType: [LocalNotifObj].self, from: localNotifsEncodingString)
        if notifs != nil {
            notifs!.append(localNotifObj)

            LocalEncoder.encode(payload: notifs, destination: localNotifsEncodingString)
        } else {
            let notifArr:[LocalNotifObj] = [localNotifObj]
            LocalEncoder.encode(payload: notifArr, destination: localNotifsEncodingString)
        }
    }
    
    func getLocalNotifs () -> [LocalNotifObj]? {
        let notifs = LocalDecoder.decode(modelType: [LocalNotifObj].self, from: localNotifsEncodingString)

        if notifs != nil {
            return notifs!
        } else {
            return nil
        }
    }
    
    func markAllNotifsAsRead () {
        var notifs = getLocalNotifs()
        
        if notifs != nil {
            for index in 0..<notifs!.count {
                notifs![index].viewed = true
            }
            
            LocalEncoder.encode(payload: notifs, destination: localNotifsEncodingString)
        }
    }
    
    func clearAllNotifs () {
        var notifs = LocalDecoder.decode(modelType: [LocalNotifObj].self, from: localNotifsEncodingString)
        if notifs != nil {
            notifs?.removeAll()
            LocalEncoder.encode(payload: notifs, destination: localNotifsEncodingString)
        }
    }
    
    func getNumberOfNewChatsForAppointment (appointmentId:String) -> Int {
        let notifs = LocalDecoder.decode(modelType: [LocalNotifObj].self, from: localNotifsEncodingString)
        
        var countToReturn:Int = 0
        
        if notifs != nil {
            for notif in notifs! {
                if notif.AppointmentId == appointmentId &&
                    notif.NotifType == .NewChatMessage &&
                    notif.viewed == false {
                    countToReturn+=1
                }
            }
        }
        
        return countToReturn
    }
    
    func clearNewChatsCountForAppointment (appointmentId:String) {
        var notifs = LocalDecoder.decode(modelType: [LocalNotifObj].self, from: localNotifsEncodingString)
                
        if notifs != nil {
            for index in 0..<notifs!.count {
                if notifs![index].AppointmentId == appointmentId && notifs![index].NotifType == .NewChatMessage {
                    notifs![index].viewed = true
                }
            }
        }
        
        LocalEncoder.encode(payload: notifs, destination: localNotifsEncodingString)
    }
}
