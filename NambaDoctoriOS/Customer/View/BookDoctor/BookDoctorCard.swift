//
//  BookDoctorCard.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/27/21.
//
 
import SwiftUI

struct BookDoctorCard: View {
    
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
                    
                    Text(customerServiceProviderVM.specialties)
                        .font(.system(size: 15))
                        .foregroundColor(Color.gray)

                    HStack {
                        VStack (alignment: .leading) {
                            Text(customerServiceProviderVM.experience)
                                .font(.system(size: 15))
                                .foregroundColor(Color.gray)
                            
                            Text(customerServiceProviderVM.fees)
                                .font(.system(size: 15))
                                .foregroundColor(Color.gray)
                        }

                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Button {
                                    self.customerServiceProviderVM.takeToBookDocView()
                                } label: {
                                    Text("Book")
                                        .padding(.horizontal)
                                        .padding(.vertical, 7)
                                        .background(Color.blue)
                                        .foregroundColor(Color.white)
                                        .cornerRadius(5)
                                }
                                
                                Button(action: {
                                    CommonDefaultModifiers.showLoader(incomingLoadingText: "Generating Link")
                                    CreateDynamicLink().makeLink(doctorId: self.customerServiceProviderVM.serviceProvider.serviceProviderID, doctorName: self.customerServiceProviderVM.serviceProviderName, profilePicURL: self.customerServiceProviderVM.serviceProvider.profilePictureURL) { url in
                                        CommonDefaultModifiers.hideLoader()
                                        shareSheet(url: url)
                                    }
                                }, label: {
                                    Image("square.and.arrow.up.on.square")
                                })
                                .padding()
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
