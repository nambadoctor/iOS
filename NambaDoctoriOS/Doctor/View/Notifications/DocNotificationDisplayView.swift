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
                            DocNotifCard(notifObj: notif)
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
                                DocNotifCard(notifObj: notif)
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

struct DocNotifCard : View {
    var notifObj:LocalNotifObj
    var body : some View {
        HStack {
            getNotifIcon()
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(getNotifIconColor())
            
            VStack (alignment: .leading, spacing: 5) {
                HStack {
                    Spacer()
                }
                Text(notifObj.Title)
                    .font(.system(size: 15))
                    .bold()

                Text(notifObj.Body)
                    .font(.system(size: 13))
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundColor(Color.gray)

            }.padding(.leading, 3)
        }
        .padding(.horizontal)
        .onTapGesture {
            LocalNotificationHandler().notifTappedHelper(notifObj: notifObj)
        }
    }
    
    func getNotifIconColor () -> Color {
        switch notifObj.NotifType {
        case .AppointmentBooked:
            return Color.green
        case .AppointmentCancelled:
            return Color.red
        case .PrescriptionSent:
            return Color.blue
        case .CallInRoom:
            return Color.green
        case .NewChatMessage:
            return Color.blue
        case .Paid:
            return Color.green
        case .ReportUploaded:
            return Color.blue
        case .Empty:
            return Color.green
        }
    }
    
    func getNotifIcon () -> Image {
        switch notifObj.NotifType {
        case .AppointmentBooked:
            return Image("checkmark.circle.fill")
        case .AppointmentCancelled:
            return Image("xmark.circle.fill")
        case .PrescriptionSent:
            return Image("checkmark.circle.fill")
        case .CallInRoom:
            return Image(systemName: "video.circle.fill")
        case .NewChatMessage:
            return Image(systemName: "message.circle.fill")
        case .Paid:
            return Image("indianrupeesign.circle.fill")
        case .ReportUploaded:
            return Image(systemName: "icloud.and.arrow.up.fill")
        case .Empty:
            return Image("")
        }
    }
}
