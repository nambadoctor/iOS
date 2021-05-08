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
        if customerVM.appointments != nil {
            ScrollView {
                ForEach(customerVM.appointments!, id: \.appointmentID) { appointment in
                    CustomerAppointmentsCardView(customerAppointmentVM: CustomerAppointmentViewModel(appointment: appointment, delegate: self.customerVM))
                }
            }
            
            if self.customerVM.takeToDetailedAppointmentView {
                NavigationLink("",
                               destination: CustomerDetailedAppointmentView(customerDetailedAppointmentVM: customerVM.makeDetailedAppointmentVM()),
                               isActive: self.$customerVM.takeToDetailedAppointmentView)
            }
        } else {
            Indicator()
        }
    }
}
