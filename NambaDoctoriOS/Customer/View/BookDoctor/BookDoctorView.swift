//
//  BookDoctorView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/27/21.
//

import SwiftUI

struct BookDoctorView: View {
    
    @EnvironmentObject var customerVM:CustomerViewModel
    
    var body: some View {
        VStack {
            if !customerVM.allServiceProviders.isEmpty {
                ScrollView {
                    
                    searchForHospitalsOrDoctorsToggle
                    
                    //bookingForChildHeader
                    
                    CategoryPicker(categoriesList: self.$customerVM.specialtyCategories, selectedCategory: self.$customerVM.selectedCategory, categoryChanged: self.customerVM.categoryChangedCallback)
                        .frame(height: 45)
                        .padding(.top)
                    
                    if self.customerVM.noDoctorForCategory {
                        VStack (alignment: .center) {
                            Spacer()
                            Image("figure.walk")
                                .scaleEffect(3)
                                .padding()
                            if self.customerVM.searchForHospitals {
                                Text("Coming Soon! There are currently no hospitals available for this specialty.")
                                    .fixedSize(horizontal: false, vertical: true)
                                    .multilineTextAlignment(.center)
                            }
                            if self.customerVM.searchForDoctors {
                                Text("Coming Soon! There are currently no doctors available for this specialty.")
                                    .fixedSize(horizontal: false, vertical: true)
                                    .multilineTextAlignment(.center)
                            }
                        }.padding()
                    } else {
                        if self.customerVM.searchForDoctors {
                            ForEach(customerVM.serviceProvidersToDisplay, id: \.serviceProviderID) { serviceProvider in
                                BookDoctorCard(customerServiceProviderVM: CustomerServiceProviderViewModel(serviceProvider: serviceProvider, customerProfile: self.customerVM.customerProfile!, callBack: self.customerVM.selectDoctorToBook(doctor:)))
                            }
                            .padding(.bottom)
                        } else if self.customerVM.searchForHospitals {
                            ForEach(customerVM.organisationsToDisplay, id: \.organisationId) { org in
                                BookOrganisationCard(organisationVM: CustomerOrganisationViewModel(organisation: org, customerProfile: self.customerVM.customerProfile!, callBack: self.customerVM.selectOrganisation(organisation:)))
                            }
                        }
                    }
                }
            } else {
                Indicator()
            }
            Spacer()
            
            if self.customerVM.takeToBookDoc {
                NavigationLink("",
                               destination: DetailedBookDoctorView(detailedBookingVM: customerVM.detailedViewDoctorVM!),
                               isActive: self.$customerVM.takeToBookDoc)
            }
            
            if self.customerVM.takeToSelectDocOfOrg {
                NavigationLink("",
                               destination: BookDoctorInOrganisationView(bookDocInOrganisationVM: BookDoctorInOrganisationViewModel(organisation: self.customerVM.selectedOrganisation!, callBack: self.customerVM.selectDoctorOfOrgToBook(doctor:), customerProfile: self.customerVM.customerProfile!)),
                               isActive: self.$customerVM.takeToSelectDocOfOrg)
            }
            
        }
        .onAppear() {
            self.customerVM.fetchCustomerProfile { _ in }
        }
    }
    
    var searchForHospitalsOrDoctorsToggle : some View {
        VStack {
            if self.customerVM.searchForDoctors {
                LargeButton(title: "Click here to Search Hospitals") {
                    self.customerVM.setSearchForHospitals()
                }
            } else if self.customerVM.searchForHospitals {
                LargeButton(title: "Click here to Search Doctors") {
                    self.customerVM.setSearchForDoctors()
                }
            }
        }
    }
    
    var bookingForChildHeader : some View {
        VStack {
            if !self.customerVM.dontShowChildBookingHeader {
                Button {
                    self.customerVM.expandAddChildHeader()
                } label: {
                    VStack (alignment: .center) {
                        if customerVM.showAddChildInstructions {
                            VStack (alignment: .leading, spacing: 10) {
                                Text("You can book an appointment for anybody even if they don't have a smart phone!")
                                    .fixedSize(horizontal: false, vertical: true).multilineTextAlignment(.leading)
                                Text("1) Select any doctor you want to book an appointment for")
                                    .fixedSize(horizontal: false, vertical: true).multilineTextAlignment(.leading)
                                Text("2) Create a profile for whoever you are booking for")
                                    .fixedSize(horizontal: false, vertical: true).multilineTextAlignment(.leading)
                                
                                Button(action: {
                                    self.customerVM.collapseChildHeader()
                                }, label: {
                                    Text("Got It!")
                                        .underline()
                                        .bold()
                                })
                                
                            }.padding(.horizontal)
                        } else {
                            HStack {
                                Spacer()
                                Text("Booking for someone else?")
                                    .bold()
                                Text("Click here")
                                    .underline()
                                    .bold()
                                Spacer()
                            }
                        }
                    }
                }
                .padding(.vertical)
                .background(Color.blue.opacity(0.2))
            }
        }
    }
}
