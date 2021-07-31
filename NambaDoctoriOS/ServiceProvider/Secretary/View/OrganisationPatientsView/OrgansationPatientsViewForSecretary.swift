//
//  OrgansationPatientsViewForSecretary.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 7/28/21.
//

import SwiftUI

struct OrgansationPatientsViewForSecretary: View {
    @EnvironmentObject var secretaryVM:SecretaryViewModel
    @State var takeToAddPatientView:Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                if secretaryVM.noOrganisationsPatients {
                    Text("Looks like you dont have any patients yet")
                } else {
                    ScrollView {
                        VStack {
                            ForEach(self.secretaryVM.organisationsPatients, id: \.CustomerId) { patient in
                                OrganisationPatientCardViewForSecretary(secretaryVM: self.secretaryVM, patientObj: patient)
                            }
                        }
                    }
                }
            }
            
            NavigationLink("",
                           destination: AddPatientAndSchedulentermediateView(addPatientVM: AddPatientViewModel(organisation: self.secretaryVM.selectedOrganization, serviceProvider: self.secretaryVM.ServiceProvider), showView: self.$takeToAddPatientView), isActive: self.$takeToAddPatientView)

            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        self.takeToAddPatientView.toggle()
                    }, label: {
                        Text("Add Patient")
                            .foregroundColor(.white)
                    })
                    .padding(10)
                    .padding(.horizontal, 5)
                    .background(Color.blue)
                    .cornerRadius(50)
                    
                    Spacer()
                }
            }
            .padding(.bottom, 10)
        }
    }
}
