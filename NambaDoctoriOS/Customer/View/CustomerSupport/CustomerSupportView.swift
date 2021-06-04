//
//  SupportView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 6/2/21.
//

import SwiftUI

struct CustomerSupportView: View {
    var body: some View {
        VStack (alignment: .center, spacing: 20) {
            
            Spacer()
            Text("Reach out to us anytime!")
            
            Button(action: {
                Image("whatsapp")
                    .scaleEffect(2)
                openWhatsapp(phoneNumber: "+917530043008")
            }, label: {
                Image("")
                Text("Whatsapp")
            })
            
            Button(action: {
                Image("phone.circle.fill")
                    .scaleEffect(2)
                callNumber(phoneNumber: "+917907144815")
            }, label: {
                Image("")
                Text("Call Us")
            })
            
            Spacer()
        }
    }
}
