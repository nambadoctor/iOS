//
//  PrescriptionsView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 25/03/21.
//

import SwiftUI

struct PrescriptionsView: View {
    
    @ObservedObject var prescriptionsVM:MedicineViewModel
    var body: some View {
        prescriptions
    }
    
    var prescriptions : some View {
        VStack (alignment: .leading) {
            
            Text("PRESCRIPTION:")
                .font(.footnote)
                .foregroundColor(Color.black.opacity(0.4))
                .bold()
            
            HStack {
                
                LargeButton(title: "Add Manually",
                            backgroundColor: Color.white,
                            foregroundColor: Color.yellow) {
                    print("Hello World")
                }
                
                LargeButton(title: "Upload Image",
                            backgroundColor: Color.green) {
                    print("Hello World")
                }
            }
        }
    }
}
