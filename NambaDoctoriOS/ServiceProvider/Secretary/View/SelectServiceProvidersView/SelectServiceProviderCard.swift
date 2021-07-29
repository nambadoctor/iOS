//
//  SelectServiceProviderCard.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 7/29/21.
//

import SwiftUI

struct SelectServiceProviderCard: View {
    
    @ObservedObject var ServiceProviderVM:ServiceProviderViewModel
    
    var body: some View {
        ZStack {
            HStack {
                
                ImageViewWithNoSheet(url: self.ServiceProviderVM.serviceProvider.profilePictureURL ?? "", height: 80, width: 80)
                    .clipShape(Circle())
                    .onTapGesture {
                        self.ServiceProviderVM.showDetailedProfileSheet = true
                    }

                VStack (alignment: .leading, spacing: 5) {
                    HStack {
                        Spacer()
                    }
                    Text(ServiceProviderVM.serviceProviderName)
                        .font(.system(size: 17))
                        .bold()
                    
                    if ServiceProviderVM.serviceProvider.additionalInfo != nil && !ServiceProviderVM.serviceProvider.additionalInfo!.Designation.isEmpty {
                        Text(ServiceProviderVM.serviceProvider.additionalInfo!.Designation[0])
                            .font(.system(size: 15))
                            .foregroundColor(Color.gray)
                    } else {
                        if ServiceProviderVM.serviceProvider.specialties != nil && !ServiceProviderVM.serviceProvider.specialties!.isEmpty {
                            Text(ServiceProviderVM.serviceProvider.specialties![0])
                                .font(.system(size: 15))
                                .foregroundColor(Color.gray)
                        } else {
                            Text("")
                                .font(.system(size: 15))
                                .foregroundColor(Color.gray)
                        }
                    }

                    HStack (alignment: .bottom) {
                        VStack (alignment: .leading) {
                            Text(ServiceProviderVM.experience)
                                .font(.system(size: 15))
                                .foregroundColor(Color.gray)
                            
                            Text(ServiceProviderVM.fees)
                                .font(.system(size: 15))
                                .foregroundColor(Color.gray)
                            
                            Text("Consult in \(ServiceProviderVM.serviceProvider.languages?.joined(separator: ",") ?? "")")
                                .font(.system(size: 15))
                                .foregroundColor(Color.blue)
                        }

                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Button {
                                    self.ServiceProviderVM.takeToBookDocView()
                                } label: {
                                    Text("Book")
                                        .padding(.horizontal)
                                        .padding(.vertical, 7)
                                        .background(Color.blue)
                                        .foregroundColor(Color.white)
                                        .cornerRadius(5)
                                }
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
