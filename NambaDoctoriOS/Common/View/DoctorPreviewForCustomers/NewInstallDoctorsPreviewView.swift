//
//  NewInstallDoctorsPreviewView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 6/30/21.
//

import SwiftUI

struct NewInstallDoctorsPreviewView: View {
    
    @ObservedObject var newInstallDoctorsPreviewVM:NewInstallDoctorsPreviewViewModel = NewInstallDoctorsPreviewViewModel()
    @State var alertItem : AlertItem?
    
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
                    
                    if !newInstallDoctorsPreviewVM.allServiceProviders.isEmpty {
                        ForEach(newInstallDoctorsPreviewVM.allServiceProviders, id: \.serviceProviderID) { serviceProvider in
                            NewInstallDoctorPreviewCard(customerServiceProviderVM: NonActionableCustomerServiceProviderViewModel(serviceProvider: serviceProvider))
                        }
                        .padding(.bottom)
                    } else {
                        Indicator()
                    }
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
        .alert(item: $alertItem) { alertItem in
            alertToShow(alertItem: alertItem)
        }
        .onAppear() {
            showAlertListener()
        }

    }
    
    func showAlertListener () {
        NotificationCenter.default.addObserver(forName: NSNotification.Name("\(SimpleStateK.showPopupChange)"), object: nil, queue: .main) { (_) in
            if alertTempItem != nil {
                self.alertItem = alertTempItem
            } else {
                self.alertItem = nil
            }
        }
    }
    
    func alertToShow (alertItem: AlertItem) -> Alert {
        guard let primaryButton = alertItem.primaryButton, let secondaryButton = alertItem.secondaryButton else{
            return Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        }
        return Alert(title: alertItem.title, message: alertItem.message, primaryButton: primaryButton, secondaryButton: secondaryButton)
    }
}
