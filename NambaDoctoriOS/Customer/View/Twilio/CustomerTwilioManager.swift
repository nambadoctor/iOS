//
//  CustomerTwilioManager.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/30/21.
//

import SwiftUI

struct CustomerTwilioManager: View {

    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var customerTwilioViewModel:CustomerTwilioViewModel
    @State private var twilioPosition = CGPoint(x: 100, y: 100)

    var body: some View {
        ZStack {
            CustomerTwilioViewHelper(customerTwilioVM: customerTwilioViewModel)
                .frame(width: customerTwilioViewModel.collapseCall ? 140 : UIScreen.main.bounds.width,
                       height: customerTwilioViewModel.collapseCall ? 200 : UIScreen.main.bounds.height)
                .position(customerTwilioViewModel.collapseCall ? twilioPosition : CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2))
                .gesture(DragGesture().onChanged({ value in
                    if customerTwilioViewModel.collapseCall {
                        self.twilioPosition = value.location
                    }
                }))
                .onTapGesture { customerTwilioViewModel.toggleTwilioViewSize() }
                .cornerRadius(10)

            if customerTwilioViewModel.viewController != nil && !customerTwilioViewModel.collapseCall {
                twilioButtonsLayout
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }

    var patientLeftView : some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Text("Waiting for patient to connect...")
                Spacer()
            }
            .padding()
            .background(Color.white.opacity(0.5))
            Spacer()
        }
    }

    var collapseCallButton : some View {
        Button {
            customerTwilioViewModel.toggleTwilioViewSize()
        } label: {
            ZStack (alignment: .center) {
                Circle().frame(width: 60, height: 60)
                    .foregroundColor(.white)
                Image(systemName: "arrow.down.forward.and.arrow.up.backward")
                    .foregroundColor(.blue)
                    .scaleEffect(1.5)
            }
        }

    }
    
    var twilioButtonsLayout : some View {
        ZStack (alignment: .bottomLeading) {
            VStack (alignment: .leading) {
                collapseCallButton.frame(width: 100).padding(.top)
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
            
            HStack {
                Spacer()
                if !customerTwilioViewModel.videoEnabled {
                    Text("Your video is currently disabled")
                        .foregroundColor(.black)
                        .bold()
                        .frame(width: 100)
                        .padding()
                        .background(Color.white.opacity(0.5))
                        .padding()
                }
            }
            .padding()
        }
    }
    
    var toggleVideo : some View {
        Button {
            self.customerTwilioViewModel.toggleVideo()
        } label: {
            ZStack (alignment: .center) {
                Circle().frame(width: 60, height: 60)
                    .foregroundColor(.white)
                if !customerTwilioViewModel.videoEnabled {
                    Image(systemName: "video.slash.fill")
                        .foregroundColor(.gray)
                        .scaleEffect(1.5)
                } else {
                    Image(systemName: "video.fill")
                        .scaleEffect(1.5)
                }
            }
        }
    }
    
    var toggleMic : some View {
        Button {
            self.customerTwilioViewModel.toggleMic()
        } label: {
            ZStack (alignment: .center) {
                Circle().frame(width: 60, height: 60)
                    .foregroundColor(.white)
                if !customerTwilioViewModel.micEnabled {
                    Image("mic.slash.fill")
                        .foregroundColor(.gray)
                        .scaleEffect(1.5)
                } else {
                    Image("mic.fill")
                        .scaleEffect(1.5)
                }
            }
        }
    }

    
    var leaveRoom : some View {
        LargeButton(title: "Leave Room") {
            customerTwilioViewModel.leaveRoom()
        }
    }

    private func killView () {
        self.presentationMode.wrappedValue.dismiss()
    }
}
