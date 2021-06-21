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
        snackBarValues.message = "You can only pay once you are recieved the prescription"
        snackBarValues.backgroundColor = .red
        snackBarValues.foregroundColor = .white

        CommonDefaultModifiers.showSnackBar()
    }
}
