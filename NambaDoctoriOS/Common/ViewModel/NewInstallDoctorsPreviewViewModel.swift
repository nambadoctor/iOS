//
//  NewInstallDoctorsPreviewViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 6/30/21.
//

import Foundation

class NewInstallDoctorsPreviewViewModel : ObservableObject {
    @Published var allServiceProviders:[CustomerServiceProviderProfile] = [CustomerServiceProviderProfile]()
    
    init() {
        getServiceProviders()
    }
    
    func getServiceProviders () {
        CustomerServiceProviderService().getAllServiceProvider(customerId: "") { serviceProviders in
            if serviceProviders != nil {
                self.allServiceProviders = serviceProviders!
            }
        }
    }
}
