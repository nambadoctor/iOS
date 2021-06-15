//
//  SnackbarHelpers.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 6/15/21.
//

import Foundation

class CustomerSnackbarHelpers {
    func waitForDoctorToCall (doctorName:String) {
        snackBarValues.imageName = "exclamationmark.circle.fill"
        snackBarValues.title = "Cannot Call"
        snackBarValues.message = "Please wait for \(doctorName) to call you."
        snackBarValues.backgroundColor = .red
        snackBarValues.foregroundColor = .white
        
        CommonDefaultModifiers.showSnackBar()
    }
    
    func waitForConsultationToFinishBeforePaying (doctorName:String) {
        snackBarValues.imageName = "indianrupeesign.circle"
        snackBarValues.title = "Cannot Pay Yet"
        snackBarValues.message = "Please pay after your consultation with \(doctorName) is finished."
        snackBarValues.backgroundColor = .red
        snackBarValues.foregroundColor = .white

        CommonDefaultModifiers.showSnackBar()
    }

}
