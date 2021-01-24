//
//  CountryPickerView.swift
//  CircleAppiOS
//
//  Created by Surya Manivannan on 26/07/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import SwiftUI

struct CountryPickerView: View {
    @Binding var selectedCountryCode:String
    @Binding var countryPickerViewDismisser:Bool
    @State var searchText:String = ""
    var body: some View {
        VStack {
            ZStack {
                TextField("Search", text: $searchText)
                    .padding(7)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
            }.padding()

            List {
                ForEach(CountryCodes.keys.sorted().filter {
                    self.searchText.isEmpty ? true : CountryCodes[$0]![0].lowercased().contains(self.searchText.lowercased())
                    },
                    id: \.self
                ) { country in
                    HStack {
                        Text(Helpers.returnFlag(country: country))
                        Text(CountryCodes[country]![0])
                        Spacer()
                        Text("+\(CountryCodes[country]![1])")
                    }.onTapGesture {
                        self.countryPickerViewDismisser.toggle()
                        self.selectedCountryCode = "+\(CountryCodes[country]![1])"
                    }
                }
            }
        }.onTapGesture {
            EndEditingHelper.endEditing()
        }
    }
}
