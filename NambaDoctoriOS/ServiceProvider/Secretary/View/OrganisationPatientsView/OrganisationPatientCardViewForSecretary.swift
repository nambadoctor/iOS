//
//  OrganisationPatientCardViewForSecretary.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 7/28/21.
//

import SwiftUI

struct OrganisationPatientCardViewForSecretary: View {
    
    @ObservedObject var secretaryVM:SecretaryViewModel
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
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
            .padding(.horizontal)
            .padding(.top, 5)
            .onTapGesture {
                self.takeToDetailedView.toggle()
            }
            
            if takeToDetailedView {
                NavigationLink("",
                               destination: DetailedDoctorMyPatientView(MyPatientVM: MyPatientViewModel(patientProfile: self.patientObj, organisation: secretaryVM.selectedOrganization, serviceProvider: secretaryVM.ServiceProvider)),
                               isActive: self.$takeToDetailedView)
            }
        }
    }
}
