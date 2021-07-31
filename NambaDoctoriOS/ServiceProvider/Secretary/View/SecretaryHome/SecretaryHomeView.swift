//
//  SecretaryHomeView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 7/28/21.
//

import SwiftUI

struct SecretaryHomeView: View {
    @ObservedObject var secretaryVM:SecretaryViewModel
    @State var alertItem : AlertItem?
    
    var body: some View {
        NavigationView {
            ZStack {
                TabView (selection: self.$secretaryVM.tabSelection) {
                    SecretaryAppointmentsView().tabItem {
                        Image("list.triangle")
                        Text("Appointments")
                    }
                    .tag(1)

                    if self.secretaryVM.selectedOrganization != nil {
                        OrgansationPatientsViewForSecretary().tabItem {
                            Image("folder.fill.badge.person.crop")
                        Text("Patients")
                        }.tag(2)
                    }

//                        DocNotificationDisplayView().tabItem {
//                            Image("bell")
//                            Text("Notifications")
//                        }.tag(4)
                }
            }
            .environmentObject(secretaryVM)
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(leading: navBarOrganizationPicker, trailing: navBarRefreshButton)
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
            AuthTokenTimeOutHelper().refresh {
                if !docAutoNav.currenltyInIntermediateView {
                    DoctorDefaultModifiers.refreshAppointments()
                }
            }
        }
        .onAppear() {
            showAlertListener()
            refreshAppointmentsListener()
            refreshFCMTokenListener()
        }
        .alert(item: $alertItem) { alertItem in
            alertToShow(alertItem: alertItem)
        }
    }
    
    var navBarOrganizationPicker : some View {
        Group {
            if self.secretaryVM.selectedOrganization != nil {
                Menu {
                    ForEach(self.secretaryVM.organisations, id: \.organisationId) { org in
                        Button {
                            self.secretaryVM.newOrganisationSelected(organisation: org)
                        } label: {
                            Text(org.name)
                        }
                    }
                } label: {
                    HStack {
                        
                        
                        Text(self.secretaryVM.selectedOrganization!.name)
                            .frame(width: Helpers.textWidth(text: self.secretaryVM.selectedOrganization!.name) + 50)
                        
                        Image("chevron.down.circle")
                        Spacer()
                    }
                }
            }
        }
    }

    var navBarRefreshButton : some View {
        Button(action: {
            secretaryVM.loadView()
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


extension SecretaryHomeView {
    func showAlertListener () {
        NotificationCenter.default.addObserver(forName: NSNotification.Name("\(SimpleStateK.showPopupChange)"), object: nil, queue: .main) { (_) in
            if alertTempItem != nil {
                self.alertItem = alertTempItem
            } else {
                self.alertItem = nil
            }
        }
    }

    func refreshAppointmentsListener () {
        NotificationCenter.default.addObserver(forName: NSNotification.Name("\(DocViewStatesK.refreshAppointmentsChange)"), object: nil, queue: .main) { (_) in
            secretaryVM.loadView()
        }
    }
    
    func refreshFCMTokenListener () {
        NotificationCenter.default.addObserver(forName: NSNotification.Name("\(DocViewStatesK.FCMTokenUpdateChange)"), object: nil, queue: .main) { (_) in
            secretaryVM.updateFCMToken()
        }
    }
    
    func alertToShow (alertItem: AlertItem) -> Alert {
        guard let primaryButton = alertItem.primaryButton, let secondaryButton = alertItem.secondaryButton else{
            return Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        }
        return Alert(title: alertItem.title, message: alertItem.message, primaryButton: primaryButton, secondaryButton: secondaryButton)
    }
}
