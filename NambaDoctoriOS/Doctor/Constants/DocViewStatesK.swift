//
//  DocViewStatesK.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 20/01/21.
//

import Foundation

enum DocViewStatesK:String {
    
    case postConsultation
    case postConsultationChange
    
    case toRefreshAppointments
    case refreshAppointmentsChange

    case endConsultationAlert
    case endConsultationAlertChange
    
    case refreshDocsPatients
    case refreshDocsPatientsChange
    
    case FCMTokenUpdate
    case FCMTokenUpdateChange

    case navigateToIntermediateView
    case navigateToIntermediateViewChange
    
    case killIntermediateView
    case killIntermediateViewChange
    
    case refreshReports
    case refreshReportsChange
}
