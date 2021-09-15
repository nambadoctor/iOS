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
                    Indicator()
                }
                Spacer()
            }
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        self.customerVM.setCategoryToAllDoctors()
                        self.customerVM.tabSelection = 3
                    }, label: {
                        Text("See All Doctors")
                            .foregroundColor(.white)
                    })
                    .padding(10)
                    .padding(.horizontal, 5)
                    .background(Color.blue)
                    .cornerRadius(50)
                    
                    Spacer()
                }
            }
            .padding(.bottom, 10)
        }
    }
}
