//
//  CustomerHome.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/27/21.
//

import SwiftUI

struct CustomerHome: View {

    @ObservedObject var customerVM:CustomerViewModel
    @State var alertItem : AlertItem?

    var body: some View {
        NavigationView {
            if !customerVM.customerLoggedIn {
                Indicator()
            } else {
                ZStack {
                    TabView (selection: self.$customerVM.tabSelection) {
                        CustomerAppointmentsView().tabItem {
                            Image("list.triangle")
                            Text("Appointments")
                        }.tag(1)

                        BookDoctorView().tabItem {
                            Image("stethoscope")
                            Text("Book Doctor")
                        }.tag(2)
                        
                        CustomerProfileView().tabItem {
                            Image("person.crop.circle.fill")
                            Text("Profile")
                        }.tag(3)
                    }
                }
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
                    if !cusAutoNav.currenltyInIntermediateView {
                        CustomerDefaultModifiers.refreshAppointments()
                    }
                }
                .environmentObject(customerVM)
                .navigationBarTitle("NambaDoctor", displayMode: .inline)
            }
        }
        .onAppear(){
            print("CUSTOMER HOME REACHED")
            showAlertListener()
            refreshFCMTokenListener()
            refreshAppointmentsListener()
            navigationToDetailedViewListener()
        }
        .alert(item: $alertItem) { alertItem in
            alertToShow(alertItem: alertItem)
        }
    }
}

extension CustomerHome {
    func alertToShow (alertItem: AlertItem) -> Alert {
        guard let primaryButton = alertItem.primaryButton, let secondaryButton = alertItem.secondaryButton else{
            return Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        }
        return Alert(title: alertItem.title, message: alertItem.message, primaryButton: primaryButton, secondaryButton: secondaryButton)
    }
}

extension CustomerHome {
    func showAlertListener () {
        NotificationCenter.default.addObserver(forName: NSNotification.Name("\(SimpleStateK.showPopupChange)"), object: nil, queue: .main) { (_) in
            if alertTempItem != nil {
                self.alertItem = alertTempItem
            } else {
                self.alertItem = nil
            }
        }
    }

    func refreshFCMTokenListener() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name("\(CustomerViewStatesK.FCMTokenUpdateChange)"), object: nil, queue: .main) { (_) in
            self.customerVM.updateFCMToken()
        }
    }

    func refreshAppointmentsListener () {
        NotificationCenter.default.addObserver(forName: NSNotification.Name("\(CustomerViewStatesK.CustomerRefreshAppointmentsChange)"), object: nil, queue: .main) { (_) in
            customerVM.retrieveCustomerAppointments()
        }
    }

    func navigationToDetailedViewListener () {
        NotificationCenter.default.addObserver(forName: NSNotification.Name("\(CustomerViewStatesK.CustomerNavigateToDetailedViewChange)"), object: nil, queue: .main) { (_) in
            self.customerVM.tabSelection = 1
            customerVM.retrieveCustomerAppointments()
        }
    }
}
