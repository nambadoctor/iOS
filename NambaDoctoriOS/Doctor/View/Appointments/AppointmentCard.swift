//
//  UpcomingAppointmentCard.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 20/01/21.
//

import SwiftUI

struct AppointmentCard: View {

    @ObservedObject private var AppointmentVM:AppointmentViewModel

    init(appointment:ServiceProviderAppointment) {
        AppointmentVM = AppointmentViewModel(appointment: appointment)
    }

    var body: some View {
        VStack (alignment: .leading ) {
            HStack {
                Image("person.crop.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                
                VStack (alignment: .leading, spacing: 5) {
                    Text(AppointmentVM.appointment.customerName)
                        .font(.system(size: 20))
                        .foregroundColor(AppointmentVM.consultationHappened ? Color.red : Color.blue)
                    Text("\(AppointmentVM.appointment.serviceFee.clean)₹")
                        .font(.subheadline)
                        .foregroundColor(Color.gray.opacity(0.8))
                }.padding(.leading, 3)
            }
            
            Divider()
                .frame(height: 1)
                .background(AppointmentVM.consultationHappened ? Color.red.opacity(0.1) : Color.blue.opacity(0.1))
                .padding([.top, .bottom], 10)
            
            if AppointmentVM.consultationHappened {
                Text("Consultation Done")
                    .font(.system(size: 19))
                    .foregroundColor(Color.red)

            } else {
                Text(AppointmentVM.getAppointmentTime())
                    .font(.system(size: 19))
                    .foregroundColor(Color.blue)
            }
            
            if self.AppointmentVM.takeToDetailedAppointment {
                NavigationLink("",
                               destination: DetailedUpcomingAppointmentView(appointment: self.AppointmentVM.appointment),
                               isActive: self.$AppointmentVM.takeToDetailedAppointment)
            }
            
            
        }
        .padding()
        .background(AppointmentVM.consultationHappened ? Color.red.opacity(0.1) : Color.blue.opacity(0.1))
        .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(AppointmentVM.consultationHappened ? Color.red.opacity(0.5) : Color.blue.opacity(0.5), lineWidth: 1)
            )
        .cornerRadius(10)
        .frame(width: UIScreen.main.bounds.width - 60)
        .onTapGesture {
            self.AppointmentVM.navigateIntoAppointment()
        }
    }
}
