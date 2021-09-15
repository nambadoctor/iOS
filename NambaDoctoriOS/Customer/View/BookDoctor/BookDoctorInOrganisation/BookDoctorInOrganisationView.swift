//
//  BookDoctorInOrganisationView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 7/31/21.
//

import SwiftUI

struct BookDoctorInOrganisationView : View {
    @ObservedObject var bookDocInOrganisationVM:BookDoctorInOrganisationViewModel
    
    var body: some View {
        ZStack {
            if self.bookDocInOrganisationVM.serviceProviders.isEmpty {
                Indicator()
            } else {
                ScrollView {
                    Text("Please select a doctor from \(self.bookDocInOrganisationVM.organisation.name) to consult with")
                        .bold()
                        .fixedSize(horizontal: false, vertical: true)
                        .font(.headline)
                        .foregroundColor(.blue)
                        .multilineTextAlignment(.center)
                        .padding(.top)
                        .padding(.horizontal)

                    Divider()
                        .padding(.horizontal)
                    
                    ForEach (self.bookDocInOrganisationVM.serviceProviders, id: \.serviceProviderID) { serviceProvider in
                        BookDoctorCard(customerServiceProviderVM: CustomerServiceProviderViewModel(serviceProvider: serviceProvider, customerProfile: self.bookDocInOrganisationVM.customerProfile, callBack: self.bookDocInOrganisationVM.selectServiceProvider, appointments: [CustomerAppointment]()))
                    }
                }
            }
        }
    }
}
