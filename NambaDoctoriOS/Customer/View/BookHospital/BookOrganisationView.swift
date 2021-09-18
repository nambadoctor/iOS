//
//  BookOrganisationView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 9/18/21.
//

import SwiftUI

struct BookOrganisationView: View {
    
    @EnvironmentObject var customerVM:CustomerViewModel
    
    var body: some View {
        VStack {
            if self.customerVM.noOrganisationForCategory {
                Text("Coming Soon! There are currently no hospitals available for this specialty.")
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
            } else {
                ScrollView {
                    ForEach(customerVM.organisations, id: \.organisationId) { org in
                        BookOrganisationCard(organisationVM: CustomerOrganisationViewModel(organisation: org, customerProfile: self.customerVM.customerProfile!, callBack: self.customerVM.selectOrganisation(organisation:)))
                    }
                }
            }
            
            if self.customerVM.takeToSelectDocOfOrg {
                NavigationLink("",
                               destination: BookDoctorInOrganisationView(bookDocInOrganisationVM: BookDoctorInOrganisationViewModel(organisation: self.customerVM.selectedOrganisation!, callBack: self.customerVM.selectDoctorOfOrgToBook(doctor:), customerProfile: self.customerVM.customerProfile!)),
                               isActive: self.$customerVM.takeToSelectDocOfOrg)
            }
        }
    }
}
