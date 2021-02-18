//
//  TokenRefreshExtension.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 19/01/21.
//

import Foundation
import Firebase

var FCMTokenId:String = ""

extension AppDelegate : MessagingDelegate {
  // [START refresh_token]
  func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
    print("Firebase registration token: \(fcmToken ?? "")")
    FCMTokenId = fcmToken ?? ""
    Logon().logonUser { _ in } //updates FCMTokenID
  }
  // [END refresh_token]
}
