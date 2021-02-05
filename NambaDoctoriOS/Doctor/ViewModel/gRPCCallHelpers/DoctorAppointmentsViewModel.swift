//
//  DoctorAppointmentsViewModel.swift
//  NambaDoctor
//
//  Created by Surya Manivannan on 14/10/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import Foundation

class DoctorAppointmentViewModel {
    static func retrieveDocAppointmentList (_ completion: @escaping ((_ appointmentList:[Nambadoctor_V1_AppointmentObject])->())) {

        let channel = ChannelManager.sharedChannelManager.getChannel()
        let appointmentClient = Nambadoctor_V1_AppointmentWorkerV1Client(channel: channel)
        
        let request = Nambadoctor_V1_AppointmentDoctorRequest.with {
            $0.doctorID = GetDocObject.docHelper.getDoctor().doctorID
        }
        
        let getDoctorsAppointment = appointmentClient.getAllDoctorAppointments(request)
        
        do {
            let response = try getDoctorsAppointment.response.wait()
            completion(response.appointmentResponse)
            print("Doctor Appointment Client Success")
        } catch {
            print("Doctor Appointment Client Failed")
        }
    }
}
