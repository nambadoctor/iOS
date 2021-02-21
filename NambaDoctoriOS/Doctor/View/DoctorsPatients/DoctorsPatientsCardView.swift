//
//  DoctorsPatientsCardView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 21/02/21.
//

import SwiftUI

struct DoctorsPatientsCardView: View {
    
    var patientObj:Patient
    
    var body: some View {
        VStack {
            Text(patientObj.fullName)
            Text(patientObj.age)
            Text(patientObj.phoneNumber)
        }
    }
}
