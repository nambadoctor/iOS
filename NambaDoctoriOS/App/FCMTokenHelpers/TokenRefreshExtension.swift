////
////  TokenRefreshExtension.swift
////  NambaDoctoriOS
////
////  Created by Surya Manivannan on 19/01/21.
////
//
//import Foundation
//import Firebase
//
var FCMTokenId:String = ""
//
//extension AppDelegate : MessagingDelegate {
//    // [START refresh_token]
//    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
//        print("Firebase registration token: \(fcmToken ?? "")")
//        FCMTokenId = fcmToken ?? ""
//        DoctorDefaultModifiers.updateFCMToken()
//    }
//    // [END refresh_token]
//
//    // Handle remote notification registration.
//    func application(_ application: UIApplication,
//                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data){
//        // Forward the token to your provider, using a custom method.
//        print("apple token: \(deviceToken.map { String(format: "%.2hhx", $0) }.joined())")
//        Messaging.messaging().apnsToken = deviceToken
//    }
//
//    func application(_ application: UIApplication,
//                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
//        // The token is not currently available.
//        print("Remote notification support is unavailable due to error: \(error.localizedDescription)")
//    }
//}
