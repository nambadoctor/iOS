//
//  SupportView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 6/2/21.
//

import SwiftUI

struct CustomerSupportView: View {
    var body: some View {
        VStack (alignment: .center, spacing: 60) {
            
            Spacer()
            Text("Reach out to us anytime!")
                .bold()
            
            Button(action: {
                
                openWhatsapp(phoneNumber: "+917530043008", textToSend: "Hello I need help with NambaDoctor")
            }, label: {
                HStack (spacing: 20) {
                    Image("whatsapp")
                        .scaleEffect(2)
                    Text("Whatsapp")
                }
            })
            
            Button(action: {
                callNumber(phoneNumber: "+917907144815")
            }, label: {
                HStack (spacing: 20) {
                    Image("phone.circle.fill")
                        .scaleEffect(2)
                    Text("Call Us")
                }
            })
            
            Spacer()
        }
    }
}
