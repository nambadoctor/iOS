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
                    ForEach (self.bookDocInOrganisationVM.serviceProviders, id: \.serviceProviderID) { serviceProvider in
                        BookDoctorCard(customerServiceProviderVM: CustomerServiceProviderViewModel(serviceProvider: serviceProvider, customerProfile: self.bookDocInOrganisationVM.customerProfile, callBack: self.bookDocInOrganisationVM.selectServiceProvider))
                    }
                }
            }
        }
    }
}
