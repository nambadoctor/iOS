//
//  OrganisationsPatientsView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 7/24/21.
//

import SwiftUI

struct OrganisationsPatientsView: View {
    @EnvironmentObject var doctorViewModel:DoctorViewModel
    @State var takeToAddPatientView:Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                if doctorViewModel.noOrganisationsPatients {
                    Text("Looks like you dont have any patients yet")
                } else {
                    ScrollView {
                        VStack {
                            ForEach(self.doctorViewModel.organisationsPatients, id: \.CustomerId) { patient in
                                OrganisationPatientCardView(doctorViewModel: self.doctorViewModel, patientObj: patient)
                            }
                        }
                    }
                    .padding()
                }
            }
            
            NavigationLink("",
                           destination: AddPatientView(addPatientVM: AddPatientViewModel(organisation: self.doctorViewModel.selectedOrganization, serviceProvider: self.doctorViewModel.doctor)), isActive: self.$takeToAddPatientView)
            
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
