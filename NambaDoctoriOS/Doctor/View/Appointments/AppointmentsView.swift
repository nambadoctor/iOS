//
//  UpcomingAppointmentsView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 19/01/21.
//

import SwiftUI

struct AppointmentsView: View {
    
    @EnvironmentObject var doctorViewModel:DoctorViewModel
    
    var body: some View {
        VStack {
            if self.doctorViewModel.noAppointments {
                Text("There are currently no appointments").padding()
            } else if self.doctorViewModel.appointments.isEmpty {
                Indicator()
            } else {
                ScrollView {
                    ForEach(doctorViewModel.appointments, id: \.appointmentID) { appointment in
                        AppointmentCard(appointment: appointment)
                    }
                }
            }
        }
    }
}
