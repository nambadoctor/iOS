//
//  CustomerProfile.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/9/21.
//

import SwiftUI

struct CustomerProfileView: View {
    
    @EnvironmentObject var customerVM:CustomerViewModel
    
    var body: some View {
        ScrollView {
            VStack (alignment: .leading) {

                HStack {
                    ImageView(imageLoader: customerVM.imageLoader!)
                    
                    VStack (alignment: .leading, spacing: 10) {
                        VStack (alignment: .leading, spacing: 3) {
                            Text("Name:")
                                .font(.footnote)
                                .bold()
                                .foregroundColor(.gray)
                            Text("\(customerVM.customerProfile!.firstName) \(customerVM.customerProfile!.lastName)")
                        }

                        VStack (alignment: .leading, spacing: 3) {
                            Text("Age:")
                                .font(.footnote)
                                .bold()
                                .foregroundColor(.gray)
                            Text("\(customerVM.customerProfile!.age)")
                        }

                        VStack (alignment: .leading, spacing: 3) {
                            Text("Gender:")
                                .font(.footnote)
                                .bold()
                                .foregroundColor(.gray)
                            Text("\(customerVM.customerProfile!.gender)")
                        }

                        VStack (alignment: .leading, spacing: 3) {
                            Text("Phone Number:")
                                .font(.footnote)
                                .bold()
                                .foregroundColor(.gray)
                            Text("\(customerVM.customerProfile!.phoneNumbers[0].countryCode)\(customerVM.customerProfile!.phoneNumbers[0].number)")
                        }
                        HStack {Spacer()}
                    }
                }
                
                HStack {
                    Text("Profile's under your account")
                        .bold()
                    
                    Spacer()
                    
                    Button(action: {
                        self.customerVM.addNewChild()
                    }, label: {
                        Text("Add Profile")
                    })
                }
                
                ForEach(self.customerVM.customerProfile!.children, id: \.ChildProfileId) {child in
                    VStack (alignment: .leading) {
                        VStack (alignment: .leading, spacing: 3) {
                            Text("Name:")
                                .font(.footnote)
                                .bold()
                                .foregroundColor(.gray)
                            Text(child.Name)
                        }

                        VStack (alignment: .leading, spacing: 3) {
                            Text("Age:")
                                .font(.footnote)
                                .bold()
                                .foregroundColor(.gray)
                            Text(child.Age)
                        }

                        VStack (alignment: .leading, spacing: 3) {
                            Text("Gender:")
                                .font(.footnote)
                                .bold()
                                .foregroundColor(.gray)
                            Text(child.Gender)
                        }

                        VStack (alignment: .leading, spacing: 3) {
                            Text("Phone Number:")
                                .font(.footnote)
                                .bold()
                                .foregroundColor(.gray)
                            Text(child.PreferredPhoneNumber.mapToNumberString())
                        }
                        
                        Button(action: {
                            self.customerVM.showEditChildSheet(child: child)
                        }, label: {
                            Text("Edit")
                        })
                        HStack {Spacer()}
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5)
                    .shadow(radius: 5)
                }
                Spacer()
            }
            .padding()
        }
        .modifier(AddProfileViewMod(addChildVM: self.customerVM.addChildProfileVM, customerProfile: self.customerVM.customerProfile!, callback: self.customerVM.refreshCustomerProfile))
        
    }
}
