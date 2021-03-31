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
    @State private var twilioPosition = CGPoint(x: 50, y: 50)
    
    var body: some View {
        ZStack {
            TwilioViewHelper(doctorTwilioVM: DoctorTwilioVM)
                .frame(width: DoctorTwilioVM.collapseCall ? 140 : UIScreen.main.bounds.width,
                       height: DoctorTwilioVM.collapseCall ? 200 : UIScreen.main.bounds.height - 20)
                .position(DoctorTwilioVM.collapseCall ? twilioPosition : CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2))
                .gesture(DragGesture().onChanged({ value in
                    if DoctorTwilioVM.collapseCall {
                        self.twilioPosition = value.location
                    }
                }))
                .onTapGesture { DoctorTwilioVM.toggleTwilioViewSize() }
                .cornerRadius(10)

            if DoctorTwilioVM.viewController != nil && !DoctorTwilioVM.collapseCall {
                twilioButtonsLayout
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }

    var collapseCallButton : some View {
        Button {
            DoctorTwilioVM.toggleTwilioViewSize()
        } label: {
            ZStack (alignment: .center) {
                Circle().frame(width: 75, height: 75)
                    .foregroundColor(.white)
                Image(systemName: "arrow.down.forward.and.arrow.up.backward")
                    .foregroundColor(.blue)
                    .scaleEffect(2)
            }
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
