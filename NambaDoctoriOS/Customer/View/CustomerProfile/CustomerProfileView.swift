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
        VStack (alignment: .leading) {
            VStack {
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
                }.padding()
            }
        }
    }
}
