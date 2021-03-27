//
//  MedicineEntryView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 26/03/21.
//

import SwiftUI

struct MedicineEntryView: View {
    @ObservedObject var medicineEntryVM:MedicineEntryViewModel = MedicineEntryViewModel()
    var body: some View {
        VStack (alignment: .leading) {
            Text("Medicine Name:")
                .font(.footnote)
                .foregroundColor(Color.black.opacity(0.4))
                .bold()
            
            ExpandingTextView(text: self.$medicineEntryVM.medicineName)
            
            Text("Dosage:")
                .font(.footnote)
                .foregroundColor(Color.black.opacity(0.4))
                .bold()
            
            ExpandingTextView(text: self.$medicineEntryVM.medicineName)
        }
        .padding()
    }
}

struct MedicineEntryView_Previews: PreviewProvider {
    static var previews: some View {
        MedicineEntryView()
    }
}
