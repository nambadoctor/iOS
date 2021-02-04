//
//  MedicineView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 22/01/21.
//

import SwiftUI

struct MedicineView: View {
    
    @ObservedObject var medicineVM:MedicineViewModel
    
    var body: some View {
        ForEach(medicineVM.medicineArr, id: \.medicineName) { medicine in
            VStack (alignment: .leading) {

                Text("\(medicine.medicineName) - \(medicine.dosage)")

                Text("\(medicine.duration) days")

                Text("\(medicineVM.timingStringForMedDisplay(medicine: medicine))")

                Text("Time to be taken: \(medicine.specialInstructions)")

                Text("\(medicine.intake)")

                Text("\(medicine.routeOfAdministration)")

                HStack {
                    HStack {
                        Spacer()
                        Text("Edit").foregroundColor(Color(UIColor.blue))
                        Spacer()
                    }.onTapGesture {
                        medicineVM.editMedicineOnTap(medicineToEdit: medicine)
                    }
                    Divider().frame(width: 0, height: 20)
                }
            }
        }.onDelete(perform: medicineVM.removePrescriptionRows)
    }
    
    
}
