//
//  PhoneNumberEntryView.swift
//  NambaDoctor
//
//  Created by Surya Manivannan on 05/01/21.
//  Copyright © 2021 SuryaManivannan. All rights reserved.
//

import SwiftUI

struct PhoneNumberEntryView: View {
    @ObservedObject var preRegUser:PreRegisteredUserVM
    @State private var showCountryCodePicker:Bool = false
    var body: some View {
        HStack{
            Text(preRegUser.user.countryCode).frame(width: 45)
                .padding()
                .onTapGesture {self.showCountryCodePicker.toggle()}
                .background(Color(UIColor.LightGrey))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            TextField("Number", text: self.$preRegUser.user.userNumber)
                .keyboardType(.numberPad)
                .padding()
                .background(Color(UIColor.LightGrey))
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }.padding(15)
        .padding(.top, 5)
        .sheet(isPresented: self.$showCountryCodePicker) {
            CountryPickerView(selectedCountryCode: $preRegUser.user.countryCode, countryPickerViewDismisser: $showCountryCodePicker)
        }
    }
}
