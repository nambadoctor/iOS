//
//  PutFollowUpAppointmentViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 23/01/21.
//

import Foundation

class PutFollowUpAppointmentViewModel: PutFollowUpAppointmentViewModelProtocol{
    
    var getDocObjHelper:GetDocObjectProtocol
    
    init(getDocObjHelper:GetDocObjectProtocol = GetDocObject()) {
        self.getDocObjHelper = getDocObjHelper
    }
    
    func makeFollowUpAppointment (prescriptionVM:PrescriptionViewModel, _ completion : @escaping ((_ successfull:Bool)->())) {
        
        let followUpVM = prescriptionVM.FollowUpVM
        
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        let followUpClient = Nambadoctor_V1_FollowUpWorkerV1Client(channel: channel)
        
        let request = Nambadoctor_V1_FollowUpObject.with {
            $0.discountedFee = followUpVM.nextFeeInt
            $0.nofDays = followUpVM.validityDaysInt
            $0.patientID = prescriptionVM.appointment.requestedBy
            $0.doctorID = getDocObjHelper.getDoctor().doctorID
        }
        
        let putFollowUpClient = followUpClient.writeNewFollowUp(request, callOptions: callOptions)
        
        do {
            let response = try putFollowUpClient.response.wait()
            completion(true)
            print("MakeFollowUp Success")
        } catch {
            print("MakeFollowUp Failure")
        }
    }
    
    func makeFollowUpAppointment (followUpVM:FollowUpAppointmentViewModel, patientId:String, _ completion : @escaping ((_ successfull:Bool)->())) {
        
        CommonDefaultModifiers.showLoader()
        
        let loggedInDoctor:Nambadoctor_V1_DoctorResponse = getDocObjHelper.getDoctor()

        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        let followUpClient = Nambadoctor_V1_FollowUpWorkerV1Client(channel: channel)
        
        let request = Nambadoctor_V1_FollowUpObject.with {
            $0.discountedFee = followUpVM.nextFeeInt
            $0.nofDays = followUpVM.validityDaysInt
            $0.patientID = patientId
            $0.doctorID = loggedInDoctor.doctorID
        }
        
        let putFollowUpClient = followUpClient.writeNewFollowUp(request, callOptions: callOptions)
        
        do {
            let response = try putFollowUpClient.response.wait()
            print("MakeFollowUp Success")
            CommonDefaultModifiers.hideLoader()
            completion(true)
        } catch {
            print("MakeFollowUp Failure")
        }
    }

}
