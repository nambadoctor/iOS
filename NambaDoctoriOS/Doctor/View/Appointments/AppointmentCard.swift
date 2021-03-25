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
        VStack (alignment: .leading, spacing: 10) {
            Text(AppointmentVM.appointment.customerName)
            Text("On: \(AppointmentVM.LocalTime)")
            
            if self.AppointmentVM.takeToDetailedAppointment {
                NavigationLink("",
                               destination: DetailedUpcomingAppointmentView(appointment: self.AppointmentVM.appointment),
                               isActive: self.$AppointmentVM.takeToDetailedAppointment)
            }
        }
        .onTapGesture {
            self.AppointmentVM.navigateIntoAppointment()
        }
        .padding([.leading, .trailing])
        .background(AppointmentVM.cardBackgroundColor)
        .cornerRadius(10)
        .padding(10)
        .shadow(radius: 5)
    }
}
