//
//  CustomerEasyEntryHelperView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 9/12/21.
//

import SwiftUI

struct CustomerEasyEntryHelperView: View {
    
    @EnvironmentObject var customerVM:CustomerViewModel
    @State var showDoctors:Bool = false
    @State var showHospitals:Bool = false
    
    var body: some View {
        if showDoctors == false && showHospitals == false {
            VStack {
                Text("Welcome To Nambadoctor")
                    .font(.title)
                
                Divider()
                
                Text("How can we help you?")
                
                LargeButton(title: "Find a Doctor") {
                    self.showDoctors = true
                    self.showHospitals = false
                    //self.customerVM.helpFindDoctors()
                }
                .padding()
                
                LargeButton(title: "Find a Hospital") {
                    self.showDoctors = false
                    self.showHospitals = true
                    //self.customerVM.helpFindHospitals()
                }
                .padding()

                LargeButton(title: "Help me book an appointment") {
                    openWhatsapp(phoneNumber: "+917530043008", textToSend: "Hello I need help booking an appointment")
                }
                .padding()
                
            }.padding()
        } else if showDoctors == false && showHospitals == true {
            BookOrganisationView()
                
        } else if showDoctors == true && showHospitals == false {
            BookDoctorView()
        }
        
    }
}
