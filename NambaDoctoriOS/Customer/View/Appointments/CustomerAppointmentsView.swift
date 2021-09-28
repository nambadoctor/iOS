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
        ZStack {
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
                                
                                Text("Finished Appointments")
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
                }
                else {
                    Spacer()
                    LargeButton(title: "Looks like you have no appointments yet. Click here to book your first appointment",
                                backgroundColor: Color.blue) {
                        self.customerVM.tabSelection = 3
                    }.padding()
                    Spacer()
                }
                
                if self.customerVM.takeToDetailedAppointmentView {
                    NavigationLink("",
                                   destination: CustomerDetailedAppointmentView(customerDetailedAppointmentVM: customerVM.customerAppointmentVM!),
                                   isActive: self.$customerVM.takeToDetailedAppointmentView)
                }
            }
            
            if !customerVM.upcomingAppointments.isEmpty || !customerVM.finishedAppointments.isEmpty {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            self.customerVM.showBookAppointmentHelperSheet = true
                        }, label: {
                            Text("Book New Appointment")
                                .foregroundColor(.white)
                        })
                        .padding(10)
                        .padding(.horizontal, 5)
                        .background(Color.blue)
                        .cornerRadius(50)
                        
                        Spacer()
                    }
                }
                .padding(.bottom, 10)
                .sheet(isPresented: self.$customerVM.showBookAppointmentHelperSheet) {
                    CustomerEasyEntryHelperView()
                        .environmentObject(customerVM)
                }
            }
        }
    }
}
