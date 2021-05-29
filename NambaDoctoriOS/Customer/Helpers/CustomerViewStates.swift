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
    
    case CustomerAppointmentStatus
    case CustomerAppointmentStatusChange
    
    case CustomerToRefreshAppointments
    case CustomerRefreshAppointmentsChange
    
    case CustomerNavigateToDetailedView
    case CustomerNavigateToDetailedViewChange
    
    case CustomerNavigateToBookDoctor
    case CustomerNavigateToBookDoctorChange
    
    case CustomerIncomingCallingNotif
    case CustomerIncomingCallingNotifChange
}
