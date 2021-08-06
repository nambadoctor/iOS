//
//  UpcomingAppointmentCard.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 20/01/21.
//

import SwiftUI

struct SecretaryAppointmentCard: View {

    @ObservedObject private var AppointmentVM:AppointmentViewModel

    init(appointment:ServiceProviderAppointment, appointmentSelectDelegate:SelectAppointmentDelegate) {
        AppointmentVM = AppointmentViewModel(appointment: appointment)
        AppointmentVM.selectedAppointmentDelegate = appointmentSelectDelegate
    }

    var body: some View {
        VStack (alignment: .leading ) {
            HStack {
                
                if AppointmentVM.consultationStarted {
                    ZStack {
                        Image("clock.arrow.2.circlepath")
                            .scaleEffect(1.5)
                            .padding()
                            .foregroundColor(.green)
                    }
                    .overlay(Circle()
                                .fill(Color.green.opacity(0.2))
                                .frame(width: 60, height: 60))
                } else {
                    
                    if AppointmentVM.consultationFinished {
                        ZStack {
                            Image("checkmark")
                                .scaleEffect(1.5)
                                .padding()
                                .foregroundColor(.gray)
                        }
                        .overlay(Circle()
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(width: 60, height: 60))
                    } else {
                        ZStack {
                            Image("calendar.badge.exclamationmark")
                                .scaleEffect(1.5)
                                .padding()
                                .foregroundColor(.blue)
                        }
                        .overlay(Circle()
                                    .fill(Color.blue.opacity(0.2))
                                    .frame(width: 60, height: 60))
                    }
                }
                
                VStack (alignment: .leading, spacing: 5) {
                    HStack {
                        Spacer()
                    }
                    Text(AppointmentVM.appointment.serviceProviderName)
                        .font(.system(size: 17))
                        .bold()
                    
                    Text(AppointmentVM.appointment.customerName)
                        .font(.system(size: 17))
                        .bold()
                    
                    Text(AppointmentVM.getAppointmentTime())
                        .font(.system(size: 17))
                        .foregroundColor(Color.gray)
                    
                    if AppointmentVM.appointment.IsInPersonAppointment {
                        Text("In-Person")
                            .font(.system(size: 17))
                            .foregroundColor(Color.gray)
                    } else {
                        Text("Online")
                            .font(.system(size: 17))
                            .foregroundColor(Color.gray)
                    }

                    if AppointmentVM.consultationStarted {
                        Text("Consultation In Progress...")
                            .font(.system(size: 15))
                            .foregroundColor(Color.gray)
                    } else if AppointmentVM.consultationFinished {
                        Text("Finished")
                            .font(.system(size: 15))
                            .foregroundColor(Color.gray)
                    }

                }.padding(.leading, 3)

            }.padding()
            
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(.horizontal)
        .padding(.top, 5)
        .onTapGesture {
            self.AppointmentVM.onCardClicked()
        }
    }
}
