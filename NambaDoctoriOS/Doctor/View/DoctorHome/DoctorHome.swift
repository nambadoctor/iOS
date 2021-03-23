//
//  DoctorHome.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 19/01/21.
//

import SwiftUI
import UIKit

struct DoctorHome: View {

    @State private var tabSelection:Int = 0
    @ObservedObject var doctorViewModel:DoctorViewModel
    @State var alertItem : AlertItem?
    @State var sheetItem : DoctorSheetItem?
    
    var body: some View {
        NavigationView {
            if !doctorViewModel.doctorLoggedIn {
                Indicator()
            } else {
                ZStack {
                    TabView (selection: self.$tabSelection) {
                        AppointmentsView().tabItem {
                            //Image("list.dash")
                            Text("Upcoming")
                            Text("Appointments")
                        }.tag(1)
                         
                        DoctorsPatientsView().tabItem {
                            //Image("timer")
                            Text("My")
                            Text("Patients")
                        }.tag(3)
                    }
                }
                .environmentObject(doctorViewModel)
                .navigationBarTitle("NambaDoctor", displayMode: .inline)
            }
        }.onAppear() {
            showAlertListener()
            showSheetListener()
            refreshAppointmentsListener()
        }
        .alert(item: $alertItem) { alertItem in
            alertToShow(alertItem: alertItem)
        }
        .sheet(item: $sheetItem) { sheetItem in
            NavigationView {
                if sheetItem.appointment != nil {
                    PatientInfoView(appointment: sheetItem.appointment!)
                }
            }
        }
    }
}
