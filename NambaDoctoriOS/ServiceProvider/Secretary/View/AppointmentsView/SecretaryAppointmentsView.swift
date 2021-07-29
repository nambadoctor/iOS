//
//  SecretaryAppointmentsView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 7/28/21.
//

import SwiftUI

struct SecretaryAppointmentsView: View {
    @EnvironmentObject var secretaryVM:SecretaryViewModel
    
    var body: some View {
        VStack {
            HorizontalDatePicker(datePickerVM: secretaryVM.datePickerVM)
                .background(Color.gray.opacity(0.08))
            
            if self.secretaryVM.hasAppointments {
                ScrollView {
                    ForEach(secretaryVM.organisationsAppointments, id: \.appointmentID) { appointment in
                        if secretaryVM.compareCurrentAppointmentTimeWithSelectedDate(appointment: appointment) && !appointment.customerName.isEmpty
                        {
                            SecretaryAppointmentCard(appointment: appointment, appointmentSelectDelegate: secretaryVM)
                        }
                    }
                }
            } else {
                VStack {
                    Spacer()
                    Image("calendar")
                        .scaleEffect(2.5)
                        .padding()
                    Text("No appointments for this date")
                        .font(.system(size: 20))
                    Spacer()
                }.padding()
            }
            
            if secretaryVM.takeToDetailedAppointment {
                NavigationLink("",
                               destination: DetailedAppointmentViewForSecretary(intermediateVM: IntermediateAppointmentViewModel(appointment: self.secretaryVM.selectedAppointment!)),
                               isActive: self.$secretaryVM.takeToDetailedAppointment)
            }
        }
    }
}
