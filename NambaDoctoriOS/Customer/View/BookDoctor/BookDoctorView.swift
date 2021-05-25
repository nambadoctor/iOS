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
                    .padding()
                    .background(Color.blue.opacity(0.2))
                    ForEach(customerVM.allServiceProviders, id: \.serviceProviderID) { serviceProvider in
                        BookDoctorCard(customerServiceProviderVM: CustomerServiceProviderViewModel(serviceProvider: serviceProvider, customerProfile: self.customerVM.customerProfile!))
                    }
                    .padding(.horizontal)
                }
            } else {
                Indicator()
            }
            Spacer()
        }
        .onAppear() {
            self.customerVM.fetchCustomerProfile { _ in }
        }
        .modifier(AddProfileViewMod(addChildVM: self.customerVM.addChilVM, customerProfile: self.customerVM.customerProfile!, callback: self.customerVM.addChildCallBack))
    }
}
