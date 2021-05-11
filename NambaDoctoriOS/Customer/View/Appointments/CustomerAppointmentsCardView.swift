//
//  AppointmentsCardView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/27/21.
//

import SwiftUI



struct CustomerAppointmentsCardView: View {
    
    @ObservedObject var customerAppointmentVM:CustomerAppointmentViewModel
    
    var body: some View {
        ZStack {
            HStack {
                
                VStack (spacing: 5) {
                    Text(customerAppointmentVM.startDateMonth)
                    Text(customerAppointmentVM.startDate)
                }
                .padding(8)
                .background(Color.white)
                .cornerRadius(5)
                .shadow(radius: 2)
                .padding()
                
                VStack (alignment: .leading, spacing: 5) {
                    HStack {
                        Spacer()
                    }
                    Text(customerAppointmentVM.appointment.serviceProviderName)
                        .font(.system(size: 17))
                        .bold()

                    Text(customerAppointmentVM.appointmentStatus)
                        .font(.system(size: 17))
                        .bold()

                }.padding(.leading, 3)
                
                if self.customerAppointmentVM.newChats > 0 {
                    ZStack (alignment: .center) {
                        Image(systemName: "message.fill")
                            .scaleEffect(1.5)
                            .foregroundColor(.blue)
                        Text("\(self.customerAppointmentVM.newChats)")
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .padding(.bottom, 2)
                    }
                }
            }.padding()

        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(.horizontal)
        .padding(.top, 5)
        .onTapGesture {
            customerAppointmentVM.takeToDetailedView()
        }
    }
}
