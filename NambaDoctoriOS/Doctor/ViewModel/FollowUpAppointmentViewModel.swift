//
//  FollowUpAppointmentViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 22/01/21.
//

import Foundation

class FollowUpAppointmentViewModel:ObservableObject {
    @Published var timeIndex:Int = 0
    @Published var needFollowUp:Bool = false
    @Published var nextFeeHelperString:String = ""
    @Published var validDaysHelperString:String = ""

    var generalDoctorHelpers:GeneralDoctorHelpersProtocol!
    
    init(generalDoctorHelpers:GeneralDoctorHelpersProtocol = GeneralDoctorHelpers()) {
        self.generalDoctorHelpers = generalDoctorHelpers
    }
    
    var nextFeeDisplay:String {
        return "\(nextFeeHelperString)₹"
    }
    
    var validityDaysDisplay:String {
        return "\(generalDoctorHelpers.returnNoOfDaysWithIndex(numOfDays: validDaysHelperString, timeIndex: timeIndex)) days"
    }
    
    var nextFeeInt:Int32 {
        return Int32(nextFeeHelperString)!
    }
    
    var validityDaysInt:Int32 {
        return Int32(validDaysHelperString)!
    }

    func showEntryFields () {
        if !validDaysHelperString.isEmpty || !nextFeeHelperString.isEmpty || needFollowUp {
            needFollowUp = true
        } else {
            needFollowUp = false
        }
    }

    func mapExistingValuesFromFollowUpObj(followUpObj:Nambadoctor_V1_FollowUpObject) {
        needFollowUp = true
        nextFeeHelperString = String(followUpObj.discountedFee)
        validDaysHelperString = String(followUpObj.nofDays)
    }
}
