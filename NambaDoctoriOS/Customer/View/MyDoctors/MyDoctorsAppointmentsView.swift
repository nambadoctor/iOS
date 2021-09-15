//
//  MyDoctorsAppointmentsView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 9/15/21.
//

import SwiftUI

struct MyDoctorsAppointmentsView: View {
    
    @ObservedObject var customerServiceProviderVM:CustomerServiceProviderViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(self.customerServiceProviderVM.appointments, id: \.appointmentID) { appointment in
                    CustomerAppointmentsCardView(customerAppointmentVM: CustomerAppointmentViewModel(appointment: appointment, delegate: self.customerServiceProviderVM))
                }
            }
            
            if self.customerServiceProviderVM.takeToDetailedAppointment {
                NavigationLink("",
                               destination: CustomerDetailedAppointmentView(customerDetailedAppointmentVM: self.customerServiceProviderVM.getDetailedAppointmentVM()),
                               isActive: self.$customerServiceProviderVM.takeToDetailedAppointment)
            }
        }
        .onAppear() {
            self.customerServiceProviderVM.selectedAppointment = nil
            self.customerServiceProviderVM.takeToDetailedAppointment = false
        }
    }
}
