//
//  CustomerEasyEntryHelperView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 9/12/21.
//

import SwiftUI

struct CustomerEasyEntryHelperView: View {
    
    @EnvironmentObject var customerVM:CustomerViewModel
    
    var body: some View {
        VStack {
            Text("Welcome To Nambadoctor")
                .font(.title)
            
            Divider()
            
            Text("How can we help you?")
            
            LargeButton(title: "Find a Doctor") {
                self.customerVM.helpFindDoctors()
            }
            .padding()
            
            LargeButton(title: "Find a Hospital") {
                self.customerVM.helpFindHospitals()
            }
            .padding()
                            
            LargeButton(title: "Help me book an appointment") {
                openWhatsapp(phoneNumber: "+917530043008", textToSend: "Hello I need help booking an appointment")
            }
            .padding()
            
        }.padding()
    }
}
