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
    
    var body: some View {
        NavigationView {
            if !customerVM.customerLoggedIn {
                Indicator()
            } else {
                ZStack {
                    TabView (selection: self.$tabSelection) {
                        Text("Appointments").tabItem {
                            Image("list.triangle")
                            Text("Appointments")
                        }.tag(1)
                        
                        BookDoctorView().tabItem {
                            Image("xmark")
                            Text("Book Doctor")
                        }.tag(2)
                        
                        Text("Profile").tabItem {
                            Image("person.crop.circle.fill")
                            Text("Profile")
                        }.tag(3)
                    }
                }
                .environmentObject(customerVM)
                .navigationBarTitle("NambaDoctor", displayMode: .inline)
            }
        }
    }
}
