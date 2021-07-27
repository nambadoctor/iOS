//
//  Intents.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 6/2/21.
//

import Foundation
import UIKit

func callNumber (phoneNumber:String) {
    guard let number = URL(string: "tel://" + phoneNumber) else { return }
    UIApplication.shared.open(number)
}

func openWhatsapp(phoneNumber:String, textToSend:String){
    var text = textToSend
    text = text.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
    let appURL = URL(string: "https://wa.me/\(phoneNumber)?text=\(text)")!
    if UIApplication.shared.canOpenURL(appURL) {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(appURL)
        }
    }
}
