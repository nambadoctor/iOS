//
//  TransferAppointmentSheet.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 7/26/21.
//

import SwiftUI

class TransferAppointmentViewModel : ObservableObject {
    @Published var allServiceProviders:[CustomerServiceProviderProfile] = [CustomerServiceProviderProfile]()
    var appointment:ServiceProviderAppointment
    var killView:()->()
    
    init(appointment:ServiceProviderAppointment, killView:@escaping ()->()) {
        self.appointment = appointment
        self.killView = killView
        getServiceProviders()
    }
    
    func getServiceProviders () {
        if appointment.organisationId.isEmpty {
            CustomerServiceProviderService().getAllServiceProvider(customerId: "") { serviceProviders in
                if serviceProviders != nil {
                    self.allServiceProviders = serviceProviders!
                }
            }
        } else {
            CustomerServiceProviderService().getServiceProvidersOfOrganization(organizationId: appointment.organisationId) { serviceProviders in
                if serviceProviders != nil {
                    self.allServiceProviders = serviceProviders!
                }
            }
        }
    }
}

struct TransferAppointmentSheet: View {
    @ObservedObject var transferDoctorsListVM:TransferAppointmentViewModel
    
    init(currentAppointment:ServiceProviderAppointment, killView:@escaping ()->()) {
        self.transferDoctorsListVM = TransferAppointmentViewModel(appointment: currentAppointment, killView: killView)
    }
    
    var body: some View {
        if !transferDoctorsListVM.allServiceProviders.isEmpty {
            ScrollView {
                ForEach(transferDoctorsListVM.allServiceProviders, id: \.serviceProviderID) { serviceProvider in
                    TransferAppointmentDoctorCard(transferAppointmentCardVM: TransferAppointmentDoctorCardViewModel(serviceProvider: serviceProvider, appointment: self.transferDoctorsListVM.appointment, killView: self.transferDoctorsListVM.killView))
                }
                .padding(.bottom)
            }
        } else {
            Indicator()
        }
    }
}
