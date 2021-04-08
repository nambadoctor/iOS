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
            HorizontalDatePicker(datePickerVM: doctorViewModel.datePickerVM)
                .background(Color.blue.opacity(0.1))
            ScrollView {
                if self.doctorViewModel.hasAppointments {
                    ForEach(doctorViewModel.appointments, id: \.appointmentID) { appointment in
                        if doctorViewModel.compareCurrentAppointmentTimeWithSelectedDate(appointment: appointment)
                        {
                            AppointmentCard(appointment: appointment)
                        }
                    }
                } else {
                    Text("There no appointments for this date").padding()
                }
            }
            Spacer()
        }
    }
}
