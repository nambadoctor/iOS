//
//  AddMedicine.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 22/01/21.
//

import SwiftUI

struct AddMedicine: View {

    @ObservedObject var medicineVM:MedicineViewModel

    var body: some View {
        HStack {
            Spacer()
            Text("Add Medicine").foregroundColor(Color.white)
            Spacer()
        }.padding(12)
        .background(Color(UIColor.green))
        .cornerRadius(4)
        .onTapGesture {
            medicineVM.addMedicineOnTap()
        }.sheet(isPresented: $medicineVM.medicineEntryVM.showAddMedicineSheet) {
            MedicineEntryView(medicineViewModel: medicineVM)
        }
    }
}
