//
//  UpcomingAppointmentsView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 19/01/21.
//

import SwiftUI

struct UpcomingAppointmentsView: View {
    
    @EnvironmentObject var doctorViewModel:DoctorViewModel
    
    var body: some View {
        VStack {
            if self.doctorViewModel.noUpcomingAppointments {
                Text("There are currently no upcoming appointments").padding()
            } else if self.doctorViewModel.upcomingAppointments.isEmpty {
                Indicator()
            } else {
                ScrollView {
                    ForEach(doctorViewModel.upcomingAppointments, id: \.appointmentID) { appointment in
                        UpcomingAppointmentCard(appointment: appointment)
                    }
                }
            }
        }
    }
}
