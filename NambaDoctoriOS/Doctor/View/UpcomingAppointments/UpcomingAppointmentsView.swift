//
//  UpcomingAppointmentsView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 19/01/21.
//

import SwiftUI

struct UpcomingAppointmentsView: View {
    
    @ObservedObject var doctor:DoctorViewModel
    
    var body: some View {
        VStack {
            if self.doctor.upcomingAppointments.isEmpty {
                Indicator()
            } else {
                ScrollView {
                    ForEach(doctor.upcomingAppointments) { appointment in
                        UpcomingAppointmentCard(appointment: appointment)
                    }
                }
            }
        }
    }
}
