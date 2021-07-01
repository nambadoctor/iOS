//
//  NewInstallDoctorsPreviewView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 6/30/21.
//

import SwiftUI

struct NewInstallDoctorsPreviewView: View {
    
    @ObservedObject var newInstallDoctorsPreviewVM:NewInstallDoctorsPreviewViewModel = NewInstallDoctorsPreviewViewModel()
    
    var body: some View {
        ZStack {

            ScrollView {
                VStack (alignment: .center, spacing: 10) {
                    Text("Welcome to NambaDoctor")
                        .font(.largeTitle)
                        .foregroundColor(.blue)
                        .bold()
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Image("logo")
                        .resizable()
                        .frame(width: 80, height: 80)
                    
                    Text("Explore our doctors and select who you would like to consult with")
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                        .font(.subheadline)
                    
                    ForEach(newInstallDoctorsPreviewVM.allServiceProviders, id: \.serviceProviderID) { serviceProvider in
                        NewInstallDoctorPreviewCard(customerServiceProviderVM: NonActionableCustomerServiceProviderViewModel(serviceProvider: serviceProvider))
                    }
                    .padding(.bottom)
                }
                .padding()
            }
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        LoginDefaultModifiers.takeToSignin()
                    }, label: {
                        Text("Skip To Registration")
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
