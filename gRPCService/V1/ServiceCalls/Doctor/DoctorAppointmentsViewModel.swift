//
//  DoctorAppointmentsViewModel.swift
//  NambaDoctor
//
//  Created by Surya Manivannan on 14/10/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import Foundation

class DoctorAppointmentViewModel : DoctorAppointmentViewModelProtocol {
    
    var getServiceProviderHelper:GetServiceProviderObjectProtocol!
    var appointmentObjectMapper:ServiceProviderAppointmentObjectMapper
    
    init(getServiceProviderHelper:GetServiceProviderObjectProtocol = GetServiceProviderObject(),
         appointmentObjMapper:ServiceProviderAppointmentObjectMapper = ServiceProviderAppointmentObjectMapper()) {
        self.getServiceProviderHelper = getServiceProviderHelper
        self.appointmentObjectMapper = appointmentObjMapper
    }
    
    func retrieveDocAppointmentList (_ completion: @escaping ((_ appointmentList:[ServiceProviderAppointment]?)->())) {
        
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        let appointmentClient = Nd_V1_ServiceProviderAppointmentWorkerV1Client(channel: channel)
        
        let request = Nd_V1_IdMessage.with {
            $0.id = getServiceProviderHelper.getServiceProvider().serviceProviderID.toProto
        }

        let getDoctorsAppointment = appointmentClient.getAppointments(request, callOptions: callOptions)
        
        do {
            let response = try getDoctorsAppointment.response.wait()
            let appointmentList = self.appointmentObjectMapper.grpcAppointmentToLocal(appointment: response.appointments)
            print("Doctor Appointment Client Success")
            completion(appointmentList)
        } catch {
            print("Doctor Appointment Client Failed")
            completion(nil)
        }
    }
}
