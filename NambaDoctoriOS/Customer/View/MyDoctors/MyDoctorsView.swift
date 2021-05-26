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
        VStack {
            if !customerVM.allServiceProviders.isEmpty {
                ScrollView {
                    ForEach(customerVM.myServiceProviders, id: \.serviceProviderID) { serviceProvider in
                        BookDoctorCard(customerServiceProviderVM: CustomerServiceProviderViewModel(serviceProvider: serviceProvider, customerProfile: self.customerVM.customerProfile!, callBack: self.customerVM.selectDoctorToBook(doctor:)))
                    }
                }
            } else {
                Indicator()
            }
            Spacer()
        }
    }
}
