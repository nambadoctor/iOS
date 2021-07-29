//
//  DoctorHomeShowAlert.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 11/02/21.
//

import Foundation
import SwiftUI

extension DoctorHome {
    func alertToShow (alertItem: AlertItem) -> Alert {
        guard let primaryButton = alertItem.primaryButton, let secondaryButton = alertItem.secondaryButton else{
            return Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        }
        return Alert(title: alertItem.title, message: alertItem.message, primaryButton: primaryButton, secondaryButton: secondaryButton)
    }
}
