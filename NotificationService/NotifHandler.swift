////
////  AppDelExtensions.swift
////  NambaDoctoriOS
////
////  Created by Surya Manivannan on 19/01/21.
////
//
//import UIKit
//
//extension AppDelegate : UNUserNotificationCenterDelegate {
//    // [START receive_message]
//    func application(_ application: UIApplication,
//                     didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
//        CorrelationId = UUID().uuidString
//        // If you are receiving a notification message while your app is in the background,
//        // this callback will not be fired till the user taps on the notification launching the application.
//        // TODO: Handle data of notification
//        // With swizzling disabled you must let Messaging know about the message, for Analytics
//        // Messaging.messaging().appDidReceiveMessage(userInfo)
//        // Print message ID.
//        if let messageID = userInfo[gcmMessageIDKey] {
//            print("Message ID: \(messageID)")
//        }
//        LoggerService().log(appointmentId: "", eventName: "RECIEVED NOTIFICATION")
//        // Print full message.
//        print(userInfo)
//        LocalNotificationHandler().notifRecieveHelper(userInfo: userInfo) { fire in
//            if fire {
//                FireLocalNotif().fire(userInfo: userInfo)
//            }
//        }
//    }
//
//    func application(_ application: UIApplication,
//                     didReceiveRemoteNotification userInfo: [AnyHashable: Any],
//                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
//        CorrelationId = UUID().uuidString
//        // If you are receiving a notification message while your app is in the background,
//        // this callback will not be fired till the user taps on the notification launching the application.
//        // TODO: Handle data of notification
//        // With swizzling disabled you must let Messaging know about the message, for Analytics
//        // Messaging.messaging().appDidReceiveMessage(userInfo)
//        // Print message ID.
//        if let messageID = userInfo[gcmMessageIDKey] {
//            print("Message ID: \(messageID)")
//        }
//        LoggerService().log(appointmentId: "", eventName: "RECIEVED NOTIFICATION")
//        // Print full message.
//        print(userInfo)
//        LocalNotificationHandler().notifRecieveHelper(userInfo: userInfo) { fire in
//            if fire {
//                FireLocalNotif().fire(userInfo: userInfo)
//            }
//        }
//    }
//
//    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification,
//                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//        completionHandler([.banner])
//    }
//
//    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//
//        let userInfo = response.notification.request.content.userInfo
//
//        LocalNotificationHandler().notifTappedHelper(userInfo: userInfo)
//        completionHandler()
//    }
//}
