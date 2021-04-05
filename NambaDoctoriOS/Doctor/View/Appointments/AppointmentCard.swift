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
        ZStack (alignment: .leading ) {
            
            VStack {
                Spacer()
                HStack {Spacer()}
            }.background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
            
            HStack {
                
                if AppointmentVM.consultationStarted {
                    Text(AppointmentVM.firstLetterOfCustomer)
                        .font(.system(size: 27))
                        .foregroundColor(.white)
                        .frame(width: 55, height: 55)
                        .background(Circle().fill(Color.green))
                } else {
                    Text(AppointmentVM.firstLetterOfCustomer)
                        .font(.system(size: 27))
                        .foregroundColor(.white)
                        .frame(width: 55, height: 55)
                        .background(Circle().fill(AppointmentVM.consultationFinished ? Color.gray : Color.blue))
                }
                
                VStack (alignment: .leading, spacing: 5) {
                    HStack {
                        Spacer()
                    }
                    Text(AppointmentVM.appointment.customerName)
                        .font(.system(size: 20))
                        .bold()
                    
                    if AppointmentVM.consultationStarted {
                        Text("Consultation Started")
                            .font(.system(size: 15))
                            .foregroundColor(Color.gray)
                    } else if AppointmentVM.consultationFinished {
                        Text("\(AppointmentVM.paymentStatus)")
                            .font(.system(size: 15))
                            .foregroundColor(Color.gray)
                    } else {
                        Text(AppointmentVM.getAppointmentTime())
                            .font(.system(size: 17))
                            .foregroundColor(Color.gray)
                    }

                }.padding(.leading, 3)
            }.padding()
            
            if self.AppointmentVM.takeToDetailedAppointment {
                NavigationLink("",
                               destination: IntermediateView(appointment: AppointmentVM.appointment),
                               isActive: self.$AppointmentVM.takeToDetailedAppointment)
            }
            
        }
        .frame(width: UIScreen.main.bounds.width-30, height: 70)
        .padding()
        .onTapGesture {
            self.AppointmentVM.navigateIntoAppointment()
        }
    }
}
