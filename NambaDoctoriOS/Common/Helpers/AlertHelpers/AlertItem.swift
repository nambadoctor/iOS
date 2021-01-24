//
//  AlertItem.swift
//  NambaDoctor
//
//  Created by Surya Manivannan on 04/01/21.
//  Copyright © 2021 SuryaManivannan. All rights reserved.
//

import Foundation
import SwiftUI

var alertTempItem:AlertItem? = nil

struct AlertItem: Identifiable {
    var id = UUID()
    var title = Text("")
    var message: Text?
    var dismissButton: Alert.Button?
    var primaryButton: Alert.Button?
    var secondaryButton: Alert.Button?
}
