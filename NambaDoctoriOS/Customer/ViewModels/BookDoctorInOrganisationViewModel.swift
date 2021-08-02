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
    
    @Published var killView:Bool = false
    
    init(organisation:CustomerOrganization,
         callBack:@escaping (CustomerServiceProviderProfile)->(),
         customerProfile:CustomerProfile) {
        self.organisation = organisation
        self.callBack = callBack
        self.customerProfile = customerProfile
        
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
