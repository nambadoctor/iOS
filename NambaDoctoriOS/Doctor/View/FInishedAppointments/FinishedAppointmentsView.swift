//
//  FinishedAppointmentsView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 21/01/21.
//

import SwiftUI

struct FinishedAppointmentsView: View {
    @ObservedObject var doctor:DoctorViewModel
    
    var body: some View {
        VStack {
            if self.doctor.finishedAppointments.isEmpty {
                Indicator()
            } else {
                ScrollView {
                    ForEach(doctor.finishedAppointments, id: \.appointmentID) { appointment in
                        FinishedAppointmentCard(appointment: appointment)
                    }
                }
            }
        }
    }
}
