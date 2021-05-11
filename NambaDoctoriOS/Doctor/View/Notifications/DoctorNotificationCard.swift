//
//  DoctorNotificationCard.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/10/21.
//

import SwiftUI

struct DoctorNotificationCard : View {
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
