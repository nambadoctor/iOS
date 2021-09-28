//
//  MyDoctorsView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/24/21.
//

import SwiftUI

struct MyDoctorsView: View {
    
    @EnvironmentObject var customerVM:CustomerViewModel
    
    var body: some View {
        ZStack {
            VStack (alignment: .leading) {
                if !customerVM.allServiceProviders.isEmpty {
                    Text("My Doctors")
                        .font(.title)
                        .bold()
                        .padding()
                    ScrollView {
                        ForEach(customerVM.myServiceProviders, id: \.serviceProviderID) { serviceProvider in
                            MyDoctorCard(customerServiceProviderVM: CustomerServiceProviderViewModel(serviceProvider: serviceProvider, customerProfile: self.customerVM.customerProfile!, callBack: self.customerVM.selectDoctorToBook(doctor:), appointments: self.customerVM.allAppointments))
                        }
                    }
                } else {
                    Spacer()
                    LargeButton(title: "Looks like you dont have any doctors yet. Click here to book your first appointment!",
                                backgroundColor: Color.blue) {
                        self.customerVM.tabSelection = 3
                    }.padding()
                    Spacer()
                }
                Spacer()
            }
            
            if self.customerVM.takeToBookDoc {
                NavigationLink("",
                               destination: DetailedBookDoctorView(detailedBookingVM: customerVM.detailedViewDoctorVM!),
                               isActive: self.$customerVM.takeToBookDoc)
            }
        }
        .onAppear() {self.customerVM.getMyDoctors()}
    }
}
