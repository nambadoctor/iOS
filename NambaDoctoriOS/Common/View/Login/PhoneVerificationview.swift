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
            ScrollView {
                VStack(spacing: 0){
                    
                    HStack {
                        Spacer()
                        Image("logo").resizable().frame(width: 200, height: 200)
                        Spacer()
                    }
                    
                    Text("NambaDoctor").font(.custom("Roboto-Black", size: 50)).fontWeight(.bold).fontWeight(.heavy).foregroundColor(Color.blue).bold()

                    Text("Medical Care With No Boundaries")
                        .font(Font.system(size:13))
                        .foregroundColor(.gray)

                    Text("Enter Your Number").font(Font.system(size:25)).padding(.top, 70)
                    
                    PhoneNumberEntryView(numberObj: $preRegUser.user.phNumberObj)
                    
                    Button (action: {
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

                }
            }
        }
        .alert(isPresented: self.$preRegUser.showAlert, content: {
            Alert(title: Text(preRegUser.alertMessage), dismissButton: .default(Text("Ok")))
        })
    }
}
