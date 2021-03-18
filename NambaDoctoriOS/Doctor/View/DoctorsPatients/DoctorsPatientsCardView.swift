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
        VStack {
            Text("\(patientObj.firstName) \(patientObj.lastName)")
            Text(patientObj.age)
        }
    }
}
