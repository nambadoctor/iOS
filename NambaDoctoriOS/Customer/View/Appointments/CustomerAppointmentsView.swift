//
//  AppointmentsView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/27/21.
//

import SwiftUI

struct CustomerAppointmentsView: View {
    
    @EnvironmentObject var customerVM:CustomerViewModel
    
    var body: some View {
        VStack {
            if !customerVM.upcomingAppointments.isEmpty || !customerVM.finishedAppointments.isEmpty {
                ScrollView {
                    
                    if !customerVM.upcomingAppointments.isEmpty {
                        HStack {
                            VStack {
                                Rectangle()
                                    .fill(Color.blue)
                                    .frame(height: 2.5)
                                    .edgesIgnoringSafeArea(.horizontal)
                            }
                            Text("Upcoming Appointments")
                                .bold()
                                .foregroundColor(Color.blue)
                                .multilineTextAlignment(.center)
                            VStack {
                                Rectangle()
                                    .fill(Color.blue)
                                    .frame(height: 2.5)
                                    .edgesIgnoringSafeArea(.horizontal)
                            }
                        }

                        ForEach(customerVM.upcomingAppointments, id: \.appointmentID) { appointment in
                            CustomerAppointmentsCardView(customerAppointmentVM: CustomerAppointmentViewModel(appointment: appointment, delegate: self.customerVM))
                        }
                    }

                    if !customerVM.finishedAppointments.isEmpty {
                        HStack {
                            VStack {
                                Rectangle()
                                    .fill(Color.gray)
                                    .frame(height: 2.5)
                                    .edgesIgnoringSafeArea(.horizontal)
                            }
                            
                            Text("FINISHED APPOINTMENTS")
                                .foregroundColor(Color.gray)
                                .multilineTextAlignment(.center)
                            VStack {
                                Rectangle()
                                    .fill(Color.gray)
                                    .frame(height: 2.5)
                                    .edgesIgnoringSafeArea(.horizontal)
                            }
                        }

                        ForEach(customerVM.finishedAppointments, id: \.appointmentID) { appointment in
                            CustomerAppointmentsCardView(customerAppointmentVM: CustomerAppointmentViewModel(appointment: appointment, delegate: self.customerVM))
                        }
                    }
                }
            } else {
                VStack {
                    Spacer()
                    Image("calendar")
                        .scaleEffect(2.5)
                        .padding()
                    Text("There are currently no appointments. Click me to book your first appointment!")
                        .multilineTextAlignment(.center)
                        .font(.system(size: 20))
                    Spacer()
                }
                .padding()
                .onTapGesture {
                    self.customerVM.tabSelection = 2
                }
            }
            
            if self.customerVM.takeToDetailedAppointmentView {
                NavigationLink("",
                               destination: CustomerDetailedAppointmentView(customerDetailedAppointmentVM: customerVM.makeDetailedAppointmentVM()),
                               isActive: self.$customerVM.takeToDetailedAppointmentView)
            }
        }
    }
}
