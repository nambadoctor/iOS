//
//  AppointmentsCardView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/27/21.
//

import SwiftUI

class CustomerAppointmentViewModel : ObservableObject {
    var appointment:CustomerAppointment
    
    @Published var takeToDetailedAppointmentView:Bool = false
    
    init(appointment:CustomerAppointment) {
        self.appointment = appointment
    }
    
    var appointmentStatus:String {
        if appointment.status == ConsultStateK.Confirmed.rawValue {
            return "Appointment Upcoming"
        } else if appointment.status == ConsultStateK.StartedConsultation.rawValue {
            return "In-Progress"
        } else {
            return "Please wait for prescription"
        }
    }

    var startDateMonth:String {
        return Helpers.load3LetterMonthName(timeStamp: appointment.scheduledAppointmentStartTime)
    }
    
    var startDate:String {
        return Helpers.loadDate(timeStamp: appointment.scheduledAppointmentStartTime)
    }
}

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

                if self.customerAppointmentVM.takeToDetailedAppointmentView {
                    NavigationLink("",
                                   destination: Text(""),
                                   isActive: self.$customerAppointmentVM.takeToDetailedAppointmentView)
                }
            }.padding()

        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(.horizontal)
        .padding(.top, 5)
    }
}
