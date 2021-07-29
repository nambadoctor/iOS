//
//  OrganisationsServiceProvidersViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 7/29/21.
//

import Foundation

class OrganisationsServiceProvidersViewModel : ObservableObject {
    var organisationId:String
    @Published var allServiceProviders:[ServiceProviderProfile] = [ServiceProviderProfile]()
    var callBack:(ServiceProviderProfile)->()
    
    init(orgId:String, callBack:@escaping (ServiceProviderProfile)->()) {
        self.organisationId = orgId
        self.callBack = callBack
        getServiceProviders()
    }
    
    func getServiceProviders () {
        ServiceProviderProfileService().getServiceProvidersOfOrganization(organizationId: self.organisationId) { serviceProviders in
            if serviceProviders != nil {
                self.allServiceProviders = serviceProviders!
            }
        }
    }
}
