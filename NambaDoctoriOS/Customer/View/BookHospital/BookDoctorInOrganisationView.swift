//
//  BookDoctorInOrganisationView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 7/31/21.
//

import SwiftUI

struct BookDoctorInOrganisationView : View {
    
    @Environment(\.openURL) var openURL
    @ObservedObject var bookDocInOrganisationVM:BookDoctorInOrganisationViewModel
    
    var body: some View {
        ZStack {
            if self.bookDocInOrganisationVM.serviceProviders.isEmpty {
                Indicator()
            } else {
                ScrollView {
                    HStack {
                        ImageView(imageLoader: self.bookDocInOrganisationVM.imageLoader!)
                        VStack (alignment: .leading, spacing: 15) {
                            Text(self.bookDocInOrganisationVM.organisation.name)
                                .font(.headline)
                                .foregroundColor(.blue)
                            
                            ForEach(self.bookDocInOrganisationVM.organisation.organisationTimings, id: \.organisationTimingId) { timing in
                                Text(timing.timingDescription)
                                    .foregroundColor(.gray)
                            }
                            
                            Button {
                                openURL(URL(string: self.bookDocInOrganisationVM.organisation.addresses[0].googleMapsAddress)!)
                            } label: {
                                Text(self.bookDocInOrganisationVM.organisation.addresses[0].streetAddress)
                            }
                            
                            Button {
                                callNumber(phoneNumber: "\(self.bookDocInOrganisationVM.organisation.phoneNumbers[0].countryCode)\(self.bookDocInOrganisationVM.organisation.phoneNumbers[0].number)")
                            } label: {
                                Text(self.bookDocInOrganisationVM.organisation.phoneNumbers[0].number)
                            }

                        }
                        Spacer()
                    }
                    .padding()
                    
                    Divider()
                        .padding(.horizontal)
                        .background(Color.blue)
                    
                    ForEach (self.bookDocInOrganisationVM.serviceProviders, id: \.serviceProviderID) { serviceProvider in
                        BookDoctorCard(customerServiceProviderVM: CustomerServiceProviderViewModel(serviceProvider: serviceProvider, customerProfile: self.bookDocInOrganisationVM.customerProfile, callBack: self.bookDocInOrganisationVM.selectServiceProvider, appointments: [CustomerAppointment]()))
                    }
                }
            }
        }
    }
}
