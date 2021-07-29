//
//  DocNotificationDisplayView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/21/21.
//

import SwiftUI

class DocNotifViewModel : ObservableObject {

    @Published var notifications:[LocalNotifObj]? = nil

    init() {
        refreshNotifs()
    }

    func refreshNotifs() {
        self.notifications = LocalNotifStorer().getLocalNotifs()
    }
    
    func markAllAsRead() {
        LocalNotifStorer().markAllNotifsAsRead()
    }
    
    func clearAllNotifs () {
        LocalNotifStorer().clearAllNotifs()
        refreshNotifs()
    }
}

struct DocNotificationDisplayView: View {
    @ObservedObject var DocNotifVM:DocNotifViewModel = DocNotifViewModel()
    var body: some View {
        ZStack {
            if DocNotifVM.notifications == nil {
                VStack {
                    Spacer()
                    Image("bell.slash")
                        .scaleEffect(2.5)
                        .padding()
                    Text("No new notifications")
                        .font(.system(size: 20))
                    Spacer()
                }
            } else {
                ScrollView {
                    
                    HStack {
                        Spacer()
                        Text("NEW")
                            .font(.footnote)
                            .foregroundColor(Color.gray)
                            .bold()
                        Spacer()
                    }
                    
                    ForEach(DocNotifVM.notifications!, id: \.timeStamp) { notif in
                        if !notif.viewed {
                            DoctorNotificationCard(notifObj: notif)
                            Divider()
                        }
                    }.background(Color.white)

                    HStack {
                        Spacer()
                        Text("OLD")
                            .font(.footnote)
                            .foregroundColor(Color.gray)
                            .bold()
                        Spacer()
                    }
                    
                    VStack {
                        ForEach(DocNotifVM.notifications!, id: \.timeStamp) { notif in
                            if notif.viewed {
                                DoctorNotificationCard(notifObj: notif)
                                Divider()
                            }
                        }
                    }.background(Color.gray.opacity(0.2))
                }
            }
            
            if DocNotifVM.notifications != nil {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button {
                            DocNotifVM.clearAllNotifs()
                        } label: {
                            Text("Clear All")
                                .fontWeight(.semibold)
                                .font(.system(size: 17))
                        }
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(40)
                        .padding(.bottom, 10)
                        Spacer()
                    }
                }
            }
        }.onAppear() {DocNotifVM.refreshNotifs()}
        .onDisappear(){DocNotifVM.markAllAsRead()}
    }
}
