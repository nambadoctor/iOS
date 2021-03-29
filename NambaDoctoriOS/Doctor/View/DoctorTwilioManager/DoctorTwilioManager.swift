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
                        .onTapGesture { DoctorTwilioVM.toggleTwilioViewSize() }
                        .frame(width: DoctorTwilioVM.collapseCall ? 140 : UIScreen.main.bounds.width,
                               height: DoctorTwilioVM.collapseCall ? 200 : UIScreen.main.bounds.height - 20)
                }
            }

            if DoctorTwilioVM.viewController != nil && !DoctorTwilioVM.collapseCall {
                twilioButtonsLayout
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }

    var collapseCallButton : some View {
        LargeButton(title: DoctorTwilioVM.collapseCall ? "Expand Call" : "Collapse Call") {
            DoctorTwilioVM.toggleTwilioViewSize()
        }
    }
    
    var twilioButtonsLayout : some View {
        ZStack (alignment: .bottomLeading) {
            VStack (alignment: .leading) {
                collapseCallButton.frame(width: 150).padding(.top)
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
