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
                        
                        if self.doctorViewModel.selectedOrganization != nil {
                           OrganisationsPatientsView().tabItem {
                                Image("folder.fill.badge.person.crop")
                            Text("\(self.doctorViewModel.selectedOrganization!.name) Patients")
                            }.tag(4)
                        }

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
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarItems(leading: navBarOrganizationPicker, trailing: navBarRefreshButton)
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
    
    var navBarOrganizationPicker : some View {
        Menu {
            ForEach(self.doctorViewModel.organisations, id: \.organisationId) { org in
                Button {
                    self.doctorViewModel.newOrganisationSelected(organisation: org)
                } label: {
                    Text(org.name)
                }
            }
            
            Button {
                self.doctorViewModel.newOrganisationSelected(organisation: nil)
            } label: {
                Text("NambaDoctor")
            }
        } label: {
            HStack {
                if self.doctorViewModel.selectedOrganization != nil {
                    Text(self.doctorViewModel.selectedOrganization!.name)
                        .frame(width: Helpers.textWidth(text: self.doctorViewModel.selectedOrganization!.name) + 50)
                } else {
                    Text("NambaDoctor")
                        .frame(width: Helpers.textWidth(text: "NambaDoctor") + 50)
                }
                Image("chevron.down.circle")
                Spacer()
            }
        }
    }

    var navBarRefreshButton : some View {
        Button(action: {
            doctorViewModel.loadView()
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
