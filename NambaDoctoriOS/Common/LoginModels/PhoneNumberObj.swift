//
//  PhoneNumberEntry.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 25/01/21.
//

import SwiftUI

struct PhoneNumberObj {
    var countryCode:String = "+91"
    var number:TextBindingManager = TextBindingManager()
}

class TextBindingManager: ObservableObject {
   @Published var text = "" {
       didSet {
           if text.count > characterLimit && oldValue.count <= characterLimit {
               text = oldValue
           }
       }
   }
   let characterLimit: Int = 10
}
