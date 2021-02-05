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
        
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let followUpClient = Nambadoctor_V1_FollowUpWorkerV1Client(channel: channel)
        
        let request = Nambadoctor_V1_FollowUpObject.with {
            $0.discountedFee = followUpVM.nextFeeInt
            $0.nofDays = followUpVM.validityDaysInt
            $0.patientID = prescriptionVM.appointment.requestedBy
            $0.doctorID = GetDocObject.docHelper.getDoctor().doctorID
        }
        
        let putFollowUpClient = followUpClient.writeNewFollowUp(request)
        
        do {
            let response = try putFollowUpClient.response.wait()
            completion(true)
            print("MakeFollowUp Success")
        } catch {
            print("MakeFollowUp Failure")
        }
    }
    
    func makeFollowUpAppointment (followUpVM:FollowUpAppointmentViewModel, patientId:String, _ completion : @escaping ((_ successfull:Bool)->())) {
        
        let loggedInDoctor:Nambadoctor_V1_DoctorResponse = GetDocObject.docHelper.getDoctor()

        let channel = ChannelManager.sharedChannelManager.getChannel()
        let followUpClient = Nambadoctor_V1_FollowUpWorkerV1Client(channel: channel)
        
        let request = Nambadoctor_V1_FollowUpObject.with {
            $0.discountedFee = followUpVM.nextFeeInt
            $0.nofDays = followUpVM.validityDaysInt
            $0.patientID = patientId
            $0.doctorID = loggedInDoctor.doctorID
        }
        
        let putFollowUpClient = followUpClient.writeNewFollowUp(request)
        
        do {
            let response = try putFollowUpClient.response.wait()
            completion(true)
            print("MakeFollowUp Success")
        } catch {
            print("MakeFollowUp Failure")
        }
    }

}
