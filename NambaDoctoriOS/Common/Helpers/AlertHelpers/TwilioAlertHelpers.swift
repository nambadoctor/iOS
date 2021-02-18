//
//  TwilioAlertHelpers.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 17/02/21.
//

import Foundation
import SwiftUI

class TwilioAlertHelpers {
    static func TwilioRoomShowLoadingAlert (completion: @escaping (_ showing:Bool) -> ()) {
        alertTempItem = AlertItem(title: Text("Preparing Room"), message: Text("Please wait while we start your consultation"))
        CommonDefaultModifiers.showAlert()
        completion(true)
    }

    static func TwilioRoomHideLoadingAlert () {
        alertTempItem = nil
        CommonDefaultModifiers.hideAlert()
    }
}
