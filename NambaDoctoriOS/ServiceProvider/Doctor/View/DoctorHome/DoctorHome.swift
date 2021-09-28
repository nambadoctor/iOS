//
//  DoctorHome.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 19/01/21.
//

import SwiftUI
import UIKit
 
struct DoctorHome: View {
    @ObservedObject var serviceProviderVM:DoctorViewModel
    @State var alertItem : AlertItem?
    
    var body: some View {
        NavigationView {
            ZStack {
                TabView (selection: self.$serviceProviderVM.tabSelection) {
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
                    
//                    if self.serviceProviderVM.selectedOrganization != nil {
//                       OrganisationsPatientsViewForDoctor().tabItem {
//                            Image("folder.fill.badge.person.crop")
//                        Text("\(self.serviceProviderVM.selectedOrganization!.name) Patients")
//                        }.tag(4)
//                    }

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
            .environmentObject(serviceProviderVM)
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(leading: navBarOrganizationPicker, trailing: navBarRefreshButton)
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
            ForEach(self.serviceProviderVM.organisations, id: \.organisationId) { org in
                Button {
                    self.serviceProviderVM.newOrganisationSelected(organisation: org)
                } label: {
                    Text(org.name)
                }
            }
            
            Button {
                self.serviceProviderVM.newOrganisationSelected(organisation: nil)
            } label: {
                Text("NambaDoctor")
            }
        } label: {
            HStack {
                if self.serviceProviderVM.selectedOrganization != nil {
                    Text(self.serviceProviderVM.selectedOrganization!.name)
                        .frame(width: Helpers.textWidth(text: self.serviceProviderVM.selectedOrganization!.name) + 50)
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
            serviceProviderVM.loadView()
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
