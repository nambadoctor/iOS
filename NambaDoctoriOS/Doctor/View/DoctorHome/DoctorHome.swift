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
    @State var showLoadingScreen:Bool = false
    
    var body: some View {
        NavigationView {
            if !doctorViewModel.doctorLoggedIn {
                Indicator()
            } else {
                ZStack {
                    TabView (selection: self.$tabSelection) {
                        UpcomingAppointmentsView(doctor: doctorViewModel).tabItem {
                            //Image("list.dash")
                            Text("Upcoming")
                            Text("Appointments")
                        }.tag(1)

                        FinishedAppointmentsView(doctor: doctorViewModel).tabItem {
                            //Image("timer")
                            Text("Finished")
                            Text("Appointments")
                        }.tag(2)
                    }

                    if showLoadingScreen {
                        LoadingScreen()
                    }
                }
                .navigationBarTitle("NambaDoctor", displayMode: .inline)
                .navigationBarItems(trailing: addPatientButton)
            }
        }.onAppear() {
            showAlertListener()
            showSheetListener()
            showLoadingScreenListener()
        }
        .alert(item: $alertItem) { alertItem in
            alertToShow(alertItem: alertItem)
        }
        .sheet(item: $sheetItem) { sheetItem in
            NavigationView {
                if sheetItem.appointment != nil {
                    PatientInfoView(appointment: sheetItem.appointment!)
                }
                
                if sheetItem.showAddPatient != nil {
                    AddPatientView()
                }
            }
        }
    }

    var addPatientButton : some View {
        Button {
            DoctorSheetHelpers().showAddPatientSheet()
        } label: {
            VStack {
                Text("Add")
                Text("Patient")
            }
        }
    }
}
