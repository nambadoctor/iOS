//
//  BookDoctorInOrganisationViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 8/1/21.
//

import Foundation

class BookDoctorInOrganisationViewModel : ObservableObject {
    @Published var serviceProviders:[CustomerServiceProviderProfile] = [CustomerServiceProviderProfile]()
    var organisation:CustomerOrganization
    var callBack:(CustomerServiceProviderProfile)->()
    var customerProfile:CustomerProfile
    @Published var imageLoader:ImageLoader? = nil
    
    @Published var killView:Bool = false
    
    init(organisation:CustomerOrganization,
         callBack:@escaping (CustomerServiceProviderProfile)->(),
         customerProfile:CustomerProfile) {
        self.organisation = organisation
        self.callBack = callBack
        self.customerProfile = customerProfile
        
        if !organisation.logo.isEmpty {
            self.imageLoader = ImageLoader(urlString: organisation.logo, { _ in })
        } else {
            self.imageLoader = ImageLoader(urlString: "https://wgsi.utoronto.ca/wp-content/uploads/2020/12/blank-profile-picture-png.png") {_ in}
        }
        
        getServiceProvidersForOrg()
    }
    
    func getServiceProvidersForOrg () {
        CustomerServiceProviderService().getServiceProvidersOfOrganization(organizationId: self.organisation.organisationId) { serviceProviders in
            if serviceProviders != nil {
                self.serviceProviders = serviceProviders!
            }
        }
    }
    
    func selectServiceProvider (serviceProvider:CustomerServiceProviderProfile) {
        self.callBack(serviceProvider)
    }
}
