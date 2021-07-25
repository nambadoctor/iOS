//
//  DoctorsPatientsView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 21/02/21.
//

import SwiftUI

struct DoctorsPatientsView: View {
    @EnvironmentObject var doctorViewModel:DoctorViewModel
    @State var takeToAddPatientView:Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                if doctorViewModel.noMyPatients {
                    Text("Looks like you dont have any patients yet")
                } else {
                    ScrollView {
                        VStack {
                            ForEach(self.doctorViewModel.myPatients, id: \.CustomerId) { patient in
                                DoctorsPatientsCardView(patientObj: patient)
                            }
                        }
                    }
                    .padding()
                }
            }
            
            NavigationLink("",
                           destination: AddPatientView(addPatientVM: AddPatientViewModel(organisation: self.doctorViewModel.selectedOrganization, serviceProvider: self.doctorViewModel.doctor), showView: self.$takeToAddPatientView), isActive: self.$takeToAddPatientView)
            
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
        .onAppear() {
            if self.doctorViewModel.selectedOrganization == nil {
                self.doctorViewModel.getMyFreelancePatients()
            } else {
                self.doctorViewModel.getPatientOfServiceProviderInOrganisation()
            }
        }
    }
}
