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
            
            VStack (alignment: .leading) {
                
                LargeButton(title: "Find a Doctor") {
                    
                }
                
                Spacer()
                
                LargeButton(title: "Find a Hospital") {
                    
                }
                
                Spacer()
                
                LargeButton(title: "Help me book an appointment") {
                    
                }
                
                Spacer()
                
                LargeButton(title: "View Previous Appointment") {
                    
                }
                
            }
        }.padding()
    }
}
