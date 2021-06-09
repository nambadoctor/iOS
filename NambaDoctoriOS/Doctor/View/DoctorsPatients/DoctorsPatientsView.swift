//
//  DoctorsPatientsView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 21/02/21.
//

import SwiftUI

struct DoctorsPatientsView: View {
    @EnvironmentObject var doctorViewModel:DoctorViewModel
    
    var body: some View {
        VStack {
            if doctorViewModel.myPatients.isEmpty {
                Indicator()
            } else if doctorViewModel.noPatients {
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
    }
}
