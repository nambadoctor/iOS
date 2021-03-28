//
//  DoctorsPatientsCardView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 21/02/21.
//

import SwiftUI

struct DoctorsPatientsCardView: View {
    
    var patientObj:ServiceProviderCustomerProfile

    var body: some View {
        VStack (spacing: 10) {
            Image("person.crop.circle.fill")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.green)
            Text("\(patientObj.firstName) \(patientObj.lastName)")
                .bold()
                .foregroundColor(.green)
            Text("\(patientObj.age), \(patientObj.gender)")
                .foregroundColor(.green)
        }
        .padding()
        .background(Color.green.opacity(0.2))
        .cornerRadius(10)
        .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.green.opacity(0.5), lineWidth: 1)
            )
    }
}
