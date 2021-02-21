//
//  PhoneVerificationview.swift
//  CircleAppiOS
//
//  Created by Surya Manivannan on 08/07/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import SwiftUI

struct PhoneVerificationview: View {
    @ObservedObject var preRegUser:PreRegisteredUserVM
    
    //User Interface
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 0){
                    
                    Text("NambaDoctor").font(.custom("Roboto-Black", size: 70)).foregroundColor(Color(UIColor.DarkBlue))

                    Text("Reaching the unreachable").font(Font.system(size:13)).foregroundColor(.gray)

                    Text("Verify Your Number").font(Font.system(size:25).weight(.bold)).fontWeight(.heavy).padding(.top, 70)

                    Text("Please Enter Your Number To Verify Your Account")
                        .font(Font.system(size:13))
                        .foregroundColor(.gray)
                        .padding(.top, 12)
                    
                    PhoneNumberEntryView(numberObj: $preRegUser.user.phNumberObj)
                    
                    Button (action: {
                        CommonDefaultModifiers.showLoader()
                        EndEditingHelper.endEditing()
                        preRegUser.validateNumWithFirebase()
                    }) {
                        Text("Next").frame(width: UIScreen.main.bounds.width - 30,height: 50)
                    }.foregroundColor(.white)
                    .background(Color(UIColor.MediumBlue))
                    .padding(.top, 5)
                    .cornerRadius(10)

                    NavigationLink("",
                                   destination: OTPVerificationView(preRegUser: preRegUser),
                                   isActive: $preRegUser.sendToOTPView)

                    Spacer()

                }.keyboardAdaptive(specificOffSet: 0)
            }
        }
    }
}
