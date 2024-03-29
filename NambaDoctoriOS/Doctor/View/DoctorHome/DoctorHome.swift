//
//  DoctorHome.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 19/01/21.
//

import SwiftUI
import UIKit

struct DoctorHome: View {
    @Environment(\.scenePhase) var scenePhase
    @ObservedObject var doctorViewModel:DoctorViewModel
    @State var alertItem : AlertItem?
    
    var body: some View {
        NavigationView {
            if !doctorViewModel.doctorLoggedIn {
                Indicator()
            } else {
                ZStack {
                    TabView (selection: self.$doctorViewModel.tabSelection) {
                        AppointmentsView().tabItem {
                            Image("list.triangle")
                            Text("Appointments")
                        }
                        .tag(1)

                        DoctorProfile().tabItem {
                            Image("person.crop.circle.fill")
                            Text("My Profile")
                        }.tag(2)
                        
                        DoctorsPatientsView().tabItem {
                            Image("folder.fill.badge.person.crop")
                            Text("My Patients")
                        }.tag(3)

//                        DocNotificationDisplayView().tabItem {
//                            Image("bell")
//                            Text("Notifications")
//                        }.tag(4)
                    }
                }
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
                    AuthTokenTimeOutHelper().refresh {
                        if !docAutoNav.currenltyInIntermediateView {
                            DoctorDefaultModifiers.refreshAppointments()
                        }
                    }
                }
                .environmentObject(doctorViewModel)
                .navigationBarTitle("NambaDoctor", displayMode: .inline)
                .navigationBarItems(trailing: navBarRefreshButton)
            }
        }.onAppear() {
            showAlertListener()
            refreshAppointmentsListener()
            refreshFCMTokenListener()
        }
        .alert(item: $alertItem) { alertItem in
            alertToShow(alertItem: alertItem)
        }
    }

    var navBarRefreshButton : some View {
        Button(action: {
            doctorViewModel.refreshAppointments()
            doctorViewModel.getMyPatients()
        }, label: {
            Image("arrow.clockwise")
        })
    }
    
    var navBarNotifCenterIcon : some View {
        Button(action: {
            
        }, label: {
            Image("bell")
        })
    }
}
