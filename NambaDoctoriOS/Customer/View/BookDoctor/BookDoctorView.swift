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
        if customerVM.serviceProviders != nil {
            ScrollView {
                ForEach(customerVM.serviceProviders!, id: \.serviceProviderID) { serviceProvider in
                    BookDoctorCard(customerServiceProviderVM: CustomerServiceProviderViewModel(serviceProvider: serviceProvider))
                }
            }
        } else {
            Indicator()
        }
    }
}
