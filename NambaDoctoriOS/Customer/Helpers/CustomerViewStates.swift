//
//  CustomerViewStates.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/27/21.
//

import Foundation

enum CustomerViewStatesK:String {
    case FCMTokenUpdate
    case FCMTokenUpdateChange
    
    case AppointmentStatusChange
    
    case toRefreshAppointments
    case refreshAppointmentsChange
    
    case navigateToDetailedView
    case navigateToDetailedViewChange
}
