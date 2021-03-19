//
//  FinishedAppointmentsView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 21/01/21.
//

import SwiftUI

struct FinishedAppointmentsView: View {
    @EnvironmentObject var doctorViewModel:DoctorViewModel
    
    var body: some View {
        VStack {
            if self.doctorViewModel.noFinishedAppointments {
                Text("There are currently no finished appointments").padding()
            } else if self.doctorViewModel.finishedAppointments.isEmpty {
                Indicator()
            } else {
                ScrollView {
                    ForEach(doctorViewModel.finishedAppointments, id: \.appointmentID) { appointment in
                        FinishedAppointmentCard(appointment: appointment)
                    }
                }
            }
        }
    }
}
