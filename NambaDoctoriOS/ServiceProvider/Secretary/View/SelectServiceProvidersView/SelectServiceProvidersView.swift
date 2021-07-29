//
//  SelectServiceProvidersView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 7/29/21.
//

import SwiftUI

struct SelectServiceProvidersView: View {
    @ObservedObject var organisationServiceProvidersVM:OrganisationsServiceProvidersViewModel
    
    var body: some View {
        if organisationServiceProvidersVM.allServiceProviders.isEmpty {
            Indicator()
        } else {
            ScrollView {
                ForEach(organisationServiceProvidersVM.allServiceProviders, id: \.serviceProviderID) { serviceProvider in
                    SelectServiceProviderCard(ServiceProviderVM: ServiceProviderViewModel(serviceProvider: serviceProvider, callBack: self.organisationServiceProvidersVM.callBack))
                }
            }
            .padding(.bottom)
        }
    }
}
