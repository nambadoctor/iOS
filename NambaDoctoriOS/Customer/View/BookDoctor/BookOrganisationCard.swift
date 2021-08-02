//
//  BookOrganisationCard.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 7/31/21.
//

import SwiftUI

struct BookOrganisationCard: View {
    
    @ObservedObject var organisationVM:CustomerOrganisationViewModel
    
    var body: some View {
        ZStack {
            HStack {
                
                ImageView(imageLoader: self.organisationVM.imageLoader!)
                
                VStack (alignment: .leading, spacing: 5) {
                    HStack {
                        Spacer()
                    }
                    Text(self.organisationVM.organisation.name)
                        .font(.system(size: 17))
                        .bold()
                    
                    if !organisationVM.organisation.specialities.isEmpty {
                        Text(organisationVM.specialties)
                            .font(.system(size: 15))
                            .foregroundColor(Color.gray)
                    }

                    HStack (alignment: .bottom) {
                        VStack (alignment: .leading) {
                            Text(organisationVM.organisation.type)
                                .font(.system(size: 15))
                                .foregroundColor(Color.gray)
                        }

                        HStack {
                            Spacer()
                            Button {
                                self.organisationVM.SelectOrganisation()
                            } label: {
                                Text("Select")
                                    .padding(.horizontal)
                                    .padding(.vertical, 7)
                                    .background(Color.blue)
                                    .foregroundColor(Color.white)
                                    .cornerRadius(5)
                            }
                        }
                    }
                }.padding(.leading, 3)

            }.padding()

        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(.horizontal)
        .padding(.top, 5)
    }
}
