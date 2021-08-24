//
//  ServiceProviderHome.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 7/28/21.
//

import SwiftUI

class ServiceProviderHomeViewModel : ObservableObject {
    @Published var serviceProvider:ServiceProviderProfile!
    @Published var secretaryLoggedIn:Bool = false
    @Published var doctorLoggedIn:Bool = false
    
    var userId:String
    init() {
        userId = UserIdHelper().retrieveUserId()
        fetchServiceProvider()
    }
    
    func fetchServiceProvider () {
        
        ServiceProviderProfileService().getServiceProvider(serviceProviderId: userId) { (serviceProviderObj) in
            if serviceProviderObj != nil {
                self.serviceProvider = serviceProviderObj!
                if serviceProviderObj!.serviceProviderType == "Secretary" {
                    self.secretaryLoggedIn = true
                } else {
                    self.doctorLoggedIn = true
                }
            }
        }
    }
}

struct ServiceProviderHome: View {
    @ObservedObject var serviceProviderHomeVM:ServiceProviderHomeViewModel
    
    var body: some View {
        ZStack {
            if !serviceProviderHomeVM.doctorLoggedIn && !serviceProviderHomeVM.secretaryLoggedIn {
                Indicator()
            } else if serviceProviderHomeVM.doctorLoggedIn {
                DoctorHome(serviceProviderVM: .init(serviceProvider: self.serviceProviderHomeVM.serviceProvider), alertItem: nil)
            } else if serviceProviderHomeVM.secretaryLoggedIn {
                SecretaryHomeView(secretaryVM: .init(serviceProvider: self.serviceProviderHomeVM.serviceProvider))
            }
        }
    }
}
