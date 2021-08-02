//
//  CustomerOrganisationViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 7/31/21.
//

import Foundation

class CustomerOrganisationViewModel : ObservableObject {
    var organisation:CustomerOrganization
    @Published var imageLoader:ImageLoader? = nil
    var customerProfile:CustomerProfile
    var callBack:(CustomerOrganization)->()
    
    init(organisation:CustomerOrganization,
         customerProfile:CustomerProfile,
         callBack:@escaping (CustomerOrganization)->()) {
        self.organisation = organisation
        self.customerProfile = customerProfile
        self.callBack = callBack
        
        
        if !organisation.logo.isEmpty {
            self.imageLoader = ImageLoader(urlString: organisation.logo, { _ in })
        } else {
            self.imageLoader = ImageLoader(urlString: "https://wgsi.utoronto.ca/wp-content/uploads/2020/12/blank-profile-picture-png.png") {_ in}
        }
    }
    
    var specialties: String {
        return organisation.specialities.joined(separator: ",")
    }
    
    func SelectOrganisation () {
        self.callBack(organisation)
    }
}
