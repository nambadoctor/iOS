//
//  DoctorTwilioManager.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 25/01/21.
//

import SwiftUI

struct DoctorTwilioManager: View {

    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var DoctorTwilioVM:DoctorTwilioViewModel
    
    var body: some View {
        ZStack {
            VStack {
                if DoctorTwilioVM.collapseCall {
                    Spacer()
                }
                HStack {
                    if DoctorTwilioVM.collapseCall {
                        Spacer()
                    }
                    TwilioViewHelper(doctorTwilioVM: DoctorTwilioVM)
                        .navigationBarItems(trailing: collapseCall)
                        .frame(width: DoctorTwilioVM.collapseCall ? 100 : UIScreen.main.bounds.width,
                               height: DoctorTwilioVM.collapseCall ? 180 : UIScreen.main.bounds.height - 55)
                }
            }

            if DoctorTwilioVM.viewController != nil && !DoctorTwilioVM.collapseCall {
                twilioButtonsLayout
            }
        }
        .navigationBarBackButtonHidden(true)
    }

    var collapseCall : some View {
        Button {
            DoctorTwilioVM.collapseView()
        } label: {
            Text(DoctorTwilioVM.collapseCall ? "Expand Call" : "Collapse Call")
        }
    }
    
    var twilioButtonsLayout : some View {
        ZStack (alignment: .bottomLeading) {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                }
            }
            VStack {
                HStack {
                    toggleVideo
                        .padding(.horizontal)
                    toggleMic
                        .padding(.horizontal)
                }
                leaveRoom
                    .padding()
                    .frame(width: 200)
            }
            .padding()
        }
    }
    
    var toggleVideo : some View {
        Button {
            self.DoctorTwilioVM.toggleVideo()
        } label: {
            ZStack (alignment: .center) {
                Circle().frame(width: 75, height: 75)
                    .foregroundColor(.white)
                if DoctorTwilioVM.videoEnabled {
                    Image(systemName: "video.slash.fill")
                        .foregroundColor(.gray)
                        .scaleEffect(2)
                } else {
                    Image(systemName: "video.fill")
                        .scaleEffect(2)
                }
            }
        }
    }
    
    var toggleMic : some View {
        Button {
            self.DoctorTwilioVM.toggleMic()
        } label: {
            ZStack (alignment: .center) {
                Circle().frame(width: 75, height: 75)
                    .foregroundColor(.white)
                if DoctorTwilioVM.micEnabled {
                    Image("mic.slash.fill")
                        .foregroundColor(.gray)
                        .scaleEffect(2)
                } else {
                    Image("mic.fill")
                        .scaleEffect(2)
                }
            }
        }
    }

    
    var leaveRoom : some View {
        LargeButton(title: "Leave Room") {
            DoctorTwilioVM.leaveRoom()
        }
    }

    private func killView () {
        self.presentationMode.wrappedValue.dismiss()
    }
}
