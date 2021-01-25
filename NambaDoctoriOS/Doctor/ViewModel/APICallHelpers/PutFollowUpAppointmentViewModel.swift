//
//  PutFollowUpAppointmentViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 23/01/21.
//

import Foundation

class PutFollowUpAppointmentViewModel: PutFollowUpAppointmentViewModelProtocol{
    func makeFollowUpAppointment (prescriptionVM:PrescriptionViewModel, _ completion : @escaping ((_ successfull:Bool)->())) {
        
        let followUpVM = prescriptionVM.FollowUpVM
        
        let parameters: [String: Any] = [
            "PatientId": prescriptionVM.appointment.requestedBy,
            "appointmentId": prescriptionVM.appointment.id,
            "doctorId": prescriptionVM.loggedInDoctor.id,
            "nextAppointmentFee": followUpVM.nextFeeHelperString,
            "validityDays": followUpVM.validDaysHelperString
        ]
        
        print(parameters)
        
        ApiPutCall.put(parameters: parameters, extensionURL: "patient/appointment/fee") { (success, data) in
            print("FOLLOWUP \(success)")
            completion(success)
        }
    }
    
    func makeFollowUpAppointment (followUpVM:FollowUpAppointmentViewModel, patientId:String, _ completion : @escaping ((_ successfull:Bool)->())) {
        
        let loggedInDoctor:Doctor = LocalDecoder.decode(modelType: Doctor.self, from: LocalEncodingK.userObj.rawValue)!
        
        let parameters: [String: Any] = [
            "PatientId": patientId,
            "appointmentId": "",
            "doctorId": loggedInDoctor.id,
            "nextAppointmentFee": followUpVM.nextFeeHelperString,
            "validityDays": followUpVM.validDaysHelperString
        ]
        
        print(parameters)
        
        ApiPutCall.put(parameters: parameters, extensionURL: "patient/appointment/fee") { (success, data) in
            print("FOLLOWUP \(success)")
            completion(success)
        }
    }

}
