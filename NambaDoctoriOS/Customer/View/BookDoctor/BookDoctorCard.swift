//
//  BookDoctorCard.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/27/21.
//
 
import SwiftUI

struct BookDoctorCard: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var customerServiceProviderVM:CustomerServiceProviderViewModel
    
    var body: some View {
        ZStack {
            HStack {
                
                ImageViewWithNoSheet(url: self.customerServiceProviderVM.serviceProvider.profilePictureURL, height: 80, width: 80)
                    .clipShape(Circle())
                    .onTapGesture {
                        self.customerServiceProviderVM.showDetailedProfileSheet = true
                    }
                    .sheet(isPresented: self.$customerServiceProviderVM.showDetailedProfileSheet, content: {
                        CustomerDoctorProfileView(doctorProfileVM: self.customerServiceProviderVM.getDetailedServiceProviderVM())
                    })

                VStack (alignment: .leading, spacing: 5) {
                    HStack {
                        Spacer()
                    }
                    Text(customerServiceProviderVM.serviceProviderName)
                        .font(.system(size: 17))
                        .bold()
                    
                    if !customerServiceProviderVM.serviceProvider.additionalInfo.Designation.isEmpty {
                        Text(customerServiceProviderVM.serviceProvider.additionalInfo.Designation[0])
                            .font(.system(size: 15))
                            .foregroundColor(Color.gray)
                    } else {
                        if !customerServiceProviderVM.serviceProvider.specialties.isEmpty {
                            Text(customerServiceProviderVM.serviceProvider.specialties[0])
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
                            Text(customerServiceProviderVM.experience)
                                .font(.system(size: 15))
                                .foregroundColor(Color.gray)

                            Text("Consult in \(customerServiceProviderVM.serviceProvider.languages.joined(separator: ","))")
                                .font(.system(size: 15))
                                .foregroundColor(Color.blue)
                        }

                        VStack {
                            Spacer()
                            HStack (spacing: 20) {
                                Spacer()
                                Button {
                                    self.presentationMode.wrappedValue.dismiss()
                                    self.customerServiceProviderVM.takeToBookDocView()
                                } label: {
                                    Text("Book")
                                        .padding(.horizontal)
                                        .padding(.vertical, 7)
                                        .background(Color.blue)
                                        .foregroundColor(Color.white)
                                        .cornerRadius(5)
                                }
                                
                                Button {
                                    self.customerServiceProviderVM.favoriteButtonClicked()
                                } label: {
                                    Image(self.customerServiceProviderVM.isfavoriteDoctor ? "heart.fill" : "heart")
                                        .foregroundColor(self.customerServiceProviderVM.isfavoriteDoctor ? .red : .gray)
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
