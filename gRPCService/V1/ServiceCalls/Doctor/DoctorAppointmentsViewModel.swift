//
//  DoctorAppointmentsViewModel.swift
//  NambaDoctor
//
//  Created by Surya Manivannan on 14/10/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import Foundation

class DoctorAppointmentViewModel : DoctorAppointmentViewModelProtocol {
    
    var getDoctorHelper:GetDocObjectProtocol!
    var appointmentObjectMapper:AppointmentObjMapper
    
    init(getDoctorHelper:GetDocObjectProtocol = GetDocObject(),
         appointmentObjMapper:AppointmentObjMapper = AppointmentObjMapper()) {
        self.getDoctorHelper = getDoctorHelper
        self.appointmentObjectMapper = appointmentObjMapper
    }
    
    func retrieveDocAppointmentList (_ completion: @escaping ((_ appointmentList:[Appointment]?)->())) {
        
        CommonDefaultModifiers.showLoader()

        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        let appointmentClient = Nambadoctor_V1_AppointmentWorkerV1Client(channel: channel)
        
        let request = Nambadoctor_V1_AppointmentDoctorRequest.with {
            $0.doctorID = getDoctorHelper.getDoctor().doctorID
        }

        let getDoctorsAppointment = appointmentClient.getAllDoctorAppointments(request, callOptions: callOptions)
        
        do {
            let response = try getDoctorsAppointment.response.wait()
            let appointmentList = appointmentObjectMapper.grpcAppointmentListToLocalAppointmentList(appointmentList: response.appointmentResponse)
            print("Doctor Appointment Client Success")
            CommonDefaultModifiers.hideLoader()
            completion(appointmentList)
        } catch {
            print("Doctor Appointment Client Failed")
            completion(nil)
        }
    }
}
