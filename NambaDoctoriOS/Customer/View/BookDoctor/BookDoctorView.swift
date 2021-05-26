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
                    Button {
                        self.customerVM.addChilVM.showSheet = true
                    } label: {
                        VStack (alignment: .center) {
                            Text("Booking for somebody else? Click here")
                                .bold()
                        }.frame(width: UIScreen.main.bounds.width)
                    }
                    .padding(.vertical)
                    .background(Color.blue.opacity(0.2))
                    
                    CategoryPicker(categoriesList: self.$customerVM.serviceProviderCategories, selectedCategory: self.$customerVM.selectedCategory)

                    ForEach(customerVM.allServiceProviders, id: \.serviceProviderID) { serviceProvider in
                        if serviceProvider.specialties.contains(self.customerVM.selectedCategory) || customerVM.selectedCategory == "All Doctors" {
                            BookDoctorCard(customerServiceProviderVM: CustomerServiceProviderViewModel(serviceProvider: serviceProvider, customerProfile: self.customerVM.customerProfile!, callBack: self.customerVM.selectDoctorToBook(doctor:)))
                        }
                    }
                }
            } else {
                Indicator()
            }
            Spacer()
            
            
            if self.customerVM.takeToBookDoc {
                NavigationLink("",
                               destination: DetailedBookDoctorView(detailedBookingVM: customerVM.getDetailedBookingVM()),
                               isActive: self.$customerVM.takeToBookDoc)
            }
        }
        .onAppear() {
            self.customerVM.fetchCustomerProfile { _ in }
        }
        .modifier(AddProfileViewMod(addChildVM: self.customerVM.addChilVM, customerProfile: self.customerVM.customerProfile!, callback: self.customerVM.addChildCallBack))
    }
}
