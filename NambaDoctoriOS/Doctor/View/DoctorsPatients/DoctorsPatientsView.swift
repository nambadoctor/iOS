//
//  DoctorsPatientsView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 21/02/21.
//

import SwiftUI

struct DoctorsPatientsView: View {
    @ObservedObject var doctorsPatientsView = DoctorsPatientsViewModel()
    var body: some View {
        VStack {
            if doctorsPatientsView.patientList == nil {
                Indicator()
            } else {
                List(self.doctorsPatientsView.patientList!) { patient in
                    DoctorsPatientsCardView(patientObj: patient)
                }
            }
        }
    }
}
