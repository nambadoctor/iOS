//
//  UpcomingAppointmentCard.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 20/01/21.
//

import SwiftUI

struct AppointmentCard: View {

    @ObservedObject private var AppointmentVM:AppointmentViewModel

    init(appointment:ServiceProviderAppointment, appointmentSelectDelegate:SelectAppointmentDelegate) {
        AppointmentVM = AppointmentViewModel(appointment: appointment)
        AppointmentVM.selectedAppointmentDelegate = appointmentSelectDelegate
    }

    var body: some View {
        VStack (alignment: .leading ) {
            HStack {
                
                if AppointmentVM.consultationStarted {
                    LetterOnColoredCircle(word: AppointmentVM.appointment.customerName, color: .green)
                } else {
                    LetterOnColoredCircle(word: AppointmentVM.appointment.customerName, color: AppointmentVM.consultationFinished ? Color.gray : Color.blue)
                }
                
                VStack (alignment: .leading, spacing: 5) {
                    HStack {
                        Spacer()
                    }
                    Text(AppointmentVM.appointment.customerName)
                        .font(.system(size: 20))
                        .bold()
                    
                    Text(AppointmentVM.getAppointmentTime())
                        .font(.system(size: 17))
                        .foregroundColor(Color.gray)

                    if AppointmentVM.consultationStarted {
                        Text("Consultation In Progress...")
                            .font(.system(size: 15))
                            .foregroundColor(Color.gray)
                    } else if AppointmentVM.consultationFinished {
                        Text("\(AppointmentVM.paymentStatus)")
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
