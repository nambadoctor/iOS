//
//  CustomerHome.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/27/21.
//

import SwiftUI

struct CustomerHome: View {
    
    @State private var tabSelection:Int = 2
    @ObservedObject var customerVM:CustomerViewModel
    @State var alertItem : AlertItem?

    var body: some View {
        NavigationView {
            if !customerVM.customerLoggedIn {
                Indicator()
            } else {
                ZStack {
                    TabView (selection: self.$tabSelection) {
                        CustomerAppointmentsView().tabItem {
                            Image("list.triangle")
                            Text("Appointments")
                        }.tag(1)

                        BookDoctorView().tabItem {
                            Image("xmark")
                            Text("Book Doctor")
                        }.tag(2)
                        
                        CustomerProfileView().tabItem {
                            Image("person.crop.circle.fill")
                            Text("Profile")
                        }.tag(3)
                    }
                }
                .environmentObject(customerVM)
                .navigationBarTitle("NambaDoctor", displayMode: .inline)
            }
        }
        .onAppear(){
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
        NotificationCenter.default.addObserver(forName: NSNotification.Name("\(CustomerViewStatesK.refreshAppointmentsChange)"), object: nil, queue: .main) { (_) in
            customerVM.retrieveCustomerAppointments()
        }
    }

    func navigationToDetailedViewListener () {
        NotificationCenter.default.addObserver(forName: NSNotification.Name("\(CustomerViewStatesK.navigateToDetailedViewChange)"), object: nil, queue: .main) { (_) in
            self.tabSelection = 1
            customerVM.getNavigationSelectedAppointment()
        }
    }
}
