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
            
//            switch notifType {
//            case .AppointmentBooked, .AppointmentCancelled, .Paid:
//                notifs?.append(localNotifObj)
//                break
//            case .NewChatMessage:
//                if notifs!.last?.NotifType == .NewChatMessage {
//                    notifs![notifs!.count - 1].Title = "New Messages from \(localNotifObj.Title)"
//                    notifs![notifs!.count - 1].Body = ""
//                    notifs![notifs!.count - 1].viewed = false
//                    notifs![notifs!.count - 1].timeStamp = Date().millisecondsSince1970
//                } else {
//                    notifs?.append(localNotifObj)
//                }
//            case .CallInRoom:
//                if notifs!.last?.NotifType == .CallInRoom {
//                    notifs![notifs!.count - 1].viewed = false
//                    notifs![notifs!.count - 1].timeStamp = Date().millisecondsSince1970
//                } else {
//                    notifs?.append(localNotifObj)
//                }
//            case .ReportUploaded:
//                if notifs!.last?.NotifType == .ReportUploaded {
//                    notifs![notifs!.count - 1].viewed = false
//                    notifs![notifs!.count - 1].timeStamp = Date().millisecondsSince1970
//                } else {
//                    notifs?.append(localNotifObj)
//                }
//            case .Empty:
//                break
//            }

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
}
