//
//  OTPVerificationView.swift
//  CircleAppiOS
//
//  Created by Surya Manivannan on 09/07/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import SwiftUI
import FirebaseAuth

struct OTPVerificationView: View {
    
    @ObservedObject var preRegUser:PreRegisteredUserVM
    
    var body: some View {
        ZStack{
            
            VStack(spacing: 20){
                Text("Enter OTP").font(Font.system(size:25).weight(.black)).fontWeight(.heavy).padding(.top, 70)

                Text("Enter the OTP code that you have received via sms for mobile number verification here")
                    .font(Font.system(size:13))
                    .foregroundColor(.gray)
                    .padding(.top, 12)

                TextField("OTP", text: $preRegUser.otp)
                    .keyboardType(.numberPad)
                    .padding()
                    .background(Color(UIColor.LightGrey))
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                Button (action: {
                    EndEditingHelper.endEditing()
                    CommonDefaultModifiers.showLoader()
                    preRegUser.registerUser()
                }) {
                    Text("Confirm OTP").frame(width: UIScreen.main.bounds.width - 30,height: 50)
                }.foregroundColor(.white)
                    .background(Color(UIColor.MediumBlue))
                    .padding(.top, 5)
                    .cornerRadius(10)
                Spacer()
            }.padding()
        }.keyboardAdaptive(specificOffSet: 0)
    }
}
