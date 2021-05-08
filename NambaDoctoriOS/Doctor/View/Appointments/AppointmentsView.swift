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
            
            if self.doctorViewModel.hasAppointments {
                ScrollView {
                    ForEach(doctorViewModel.appointments, id: \.appointmentID) { appointment in
                        if doctorViewModel.compareCurrentAppointmentTimeWithSelectedDate(appointment: appointment) && !appointment.customerName.isEmpty
                        {
                            AppointmentCard(appointment: appointment, appointmentSelectDelegate: doctorViewModel)
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
            
            if doctorViewModel.takeToDetailedAppointment {
                NavigationLink("",
                               destination: DoctorIntermediateView(appointment: doctorViewModel.selectedAppointment!),
                               isActive: $doctorViewModel.takeToDetailedAppointment)
            }
        }
        .onAppear() {
            self.doctorViewModel.getNotificationSelectedAppointment()
            NotificationCenter.default.addObserver(forName: NSNotification.Name("\(DocViewStatesK.navigateToIntermediateViewChange)"), object: nil, queue: .main) { (_) in
                self.doctorViewModel.getNotificationSelectedAppointment()
            }
        }
    }
}
