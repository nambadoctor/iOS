//
//  PhoneNumberEntryView.swift
//  NambaDoctor
//
//  Created by Surya Manivannan on 05/01/21.
//  Copyright © 2021 SuryaManivannan. All rights reserved.
//

import SwiftUI

struct PhoneNumberEntryView: View {
    @Binding var numberObj:PhoneNumberObj
    @State private var showCountryCodePicker:Bool = false
    var isDisabled:Bool = false

    var body: some View {
        HStack{
            Text(numberObj.countryCode).frame(width: 45)
                .padding()
                .onTapGesture {
                    if !isDisabled {
                        self.showCountryCodePicker.toggle()
                    }
                }
                .background(Color(UIColor.LightGrey))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            TextField("Number", text: $numberObj.number.text)
                .disabled(isDisabled)
                .keyboardType(.numberPad)
                .padding()
                .background(Color(UIColor.LightGrey))
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .padding(.top, 5)
        .sheet(isPresented: self.$showCountryCodePicker) {
            CountryPickerView(selectedCountryCode: $numberObj.countryCode, countryPickerViewDismisser: $showCountryCodePicker)
        }
    }
}
