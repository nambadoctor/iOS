//
//  DoctorsPatientsCardView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 21/02/21.
//

import SwiftUI

struct DoctorsPatientsCardView: View {
    
    var patientObj:ServiceProviderMyPatientProfile
    
    @State var takeToDetailedView:Bool = false

    var body: some View {
        ZStack {
            HStack (spacing: 10) {
                Image("person.crop.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.blue)
                VStack (alignment: .leading) {
                    Text("\(patientObj.Name)")
                        .bold()
                        .foregroundColor(.blue)
                    Text("\(patientObj.Age) - \(patientObj.Gender)")
                        .foregroundColor(.blue)
                }
                
                Spacer()
            }
            .padding()
            .background(Color.blue.opacity(0.2))
            .cornerRadius(10)
            .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.blue.opacity(0.5), lineWidth: 1)
                )
            .onTapGesture {
                self.takeToDetailedView.toggle()
            }
            
            if takeToDetailedView {
                NavigationLink("",
                               destination: DetailedDoctorMyPatientView(MyPatientVM: MyPatientViewModel(patientProfile: self.patientObj)),
                               isActive: self.$takeToDetailedView)
            }
        }
    }
}
