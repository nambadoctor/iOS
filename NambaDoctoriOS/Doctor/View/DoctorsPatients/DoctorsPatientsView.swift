//
//  DoctorsPatientsView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 21/02/21.
//

import SwiftUI

struct DoctorsPatientsView: View {
    @EnvironmentObject var doctorViewModel:DoctorViewModel
    
    private var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        VStack {
            if doctorViewModel.myPatients.isEmpty {
                Indicator()
            } else if doctorViewModel.noPatients {
                Text("Looks like you dont have any patients yet")
            } else {
                ScrollView {
                    GeometryReader { geo in
                        LazyVGrid(columns: gridItemLayout, spacing: 20) {
                            ForEach(self.doctorViewModel.myPatients, id: \.customerID) { patient in
                                DoctorsPatientsCardView(patientObj: patient)
                            }
                        }
                    }
                }
                .padding()
            }
        }
    }
}
