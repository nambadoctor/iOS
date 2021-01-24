//
//  DoctorAppointmentsViewModel.swift
//  NambaDoctor
//
//  Created by Surya Manivannan on 14/10/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import Foundation

class DoctorAppointmentViewModel {
    static func retrieveDocAppointmentList (_ completion: @escaping ((_ appointmentList:[Appointment])->())) {
        
        ApiGetCall.get(extensionURL: "doctor/appointments") { (data) in
            do {
                let appointments = try JSONDecoder().decode([Appointment].self, from: data)
                completion(appointments)
            } catch {
                print(error)
            }
        }
    }
}
