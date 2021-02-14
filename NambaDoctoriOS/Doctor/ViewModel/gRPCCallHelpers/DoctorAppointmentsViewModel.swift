//
//  DoctorAppointmentsViewModel.swift
//  NambaDoctor
//
//  Created by Surya Manivannan on 14/10/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import Foundation

class DoctorAppointmentViewModel : DoctorAppointmentViewModelProtocol {
    func retrieveDocAppointmentList (_ completion: @escaping ((_ appointmentList:[Nambadoctor_V1_AppointmentObject])->())) {
        
        CommonDefaultModifiers.showLoader()

        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        let appointmentClient = Nambadoctor_V1_AppointmentWorkerV1Client(channel: channel)
        
        let request = Nambadoctor_V1_AppointmentDoctorRequest.with {
            $0.doctorID = GetDocObject().getDoctor().doctorID
        }

        let getDoctorsAppointment = appointmentClient.getAllDoctorAppointments(request, callOptions: callOptions)
        
        do {
            let response = try getDoctorsAppointment.response.wait()
            print("Doctor Appointment Client Success")
            CommonDefaultModifiers.hideLoader()
            completion(response.appointmentResponse)
        } catch {
            print("Doctor Appointment Client Failed")
        }
    }
}
