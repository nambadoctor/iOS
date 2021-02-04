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
        
        
    }
}
