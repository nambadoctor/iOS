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

func openWhatsapp(phoneNumber:String){
    let urlWhats = "whatsapp://send?phone=\(phoneNumber)"
    if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed){
        if let whatsappURL = URL(string: urlString) {
            if UIApplication.shared.canOpenURL(whatsappURL){
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(whatsappURL)
                }
            }
            else {
                print("Install Whatsapp")
            }
        }
    }
}
