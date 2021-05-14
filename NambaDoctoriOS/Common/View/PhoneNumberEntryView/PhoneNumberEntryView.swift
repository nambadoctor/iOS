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
    var body: some View {
        HStack{
            Text(numberObj.countryCode).frame(width: 45)
                .padding()
                .onTapGesture {self.showCountryCodePicker.toggle()}
                .background(Color(UIColor.LightGrey))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            TextField("Number", text: $numberObj.number.text)
                .keyboardType(.numberPad)
                .padding()
                .background(Color(UIColor.LightGrey))
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }.padding(15)
        .padding(.top, 5)
        .sheet(isPresented: self.$showCountryCodePicker) {
            CountryPickerView(selectedCountryCode: $numberObj.countryCode, countryPickerViewDismisser: $showCountryCodePicker)
        }
        .onAppear() {
            let defaults = UserDefaults.standard
            let dictionary = defaults.dictionaryRepresentation()
            dictionary.keys.forEach { key in
                defaults.removeObject(forKey: key)
            }
        }
    }
}
