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
            .navigationBarTitle("NambaDoctor")
            .navigationBarItems(trailing: addPatientButton)
        }.onAppear() {
            showAlertListener()
            showSheetListener()
        }
        .alert(item: $alertItem) { alertItem in
            alertToShow(alertItem: alertItem)
        }
        .sheet(item: $sheetItem) { sheetItem in
            if sheetItem.appointment != nil {
                PatientInfoView(appointment: sheetItem.appointment!)
            }
            
            if sheetItem.showAddPatient != nil {
                AddPatientView()
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

extension DoctorHome {
    func alertToShow (alertItem: AlertItem) -> Alert {
        guard let primaryButton = alertItem.primaryButton, let secondaryButton = alertItem.secondaryButton else{
            return Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        }
        return Alert(title: alertItem.title, message: alertItem.message, primaryButton: primaryButton, secondaryButton: secondaryButton)
    }
    
    func showAlertListener () {
        NotificationCenter.default.addObserver(forName: NSNotification.Name("\(SimpleStateK.showPopupChange)"), object: nil, queue: .main) { (_) in
            if alertTempItem != nil {
                self.alertItem = alertTempItem
            }
        }
    }
    
    func showSheetListener () {
        NotificationCenter.default.addObserver(forName: NSNotification.Name("\(SimpleStateK.showSheetChange)"), object: nil, queue: .main) { (_) in
            if sheetTempItem != nil {
                self.sheetItem = sheetTempItem
            }
        }
    }
}
