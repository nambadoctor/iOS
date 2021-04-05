//
//  MedicineEntryView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 26/03/21.
//

import SwiftUI

struct MedicineEntryView: View {
    @EnvironmentObject var medicineVM:MedicineViewModel

    var body: some View {
        ScrollView {
            VStack (alignment: .leading) {
                HStack {
                    Spacer()
                    Button {
                        medicineVM.showMedicineEntrySheet.toggle()
                    } label: {
                        Image("xmark.circle")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .foregroundColor(.blue)
                    }
                }
                Text("Medicine Name:")
                    .font(.footnote)
                    .foregroundColor(Color.black.opacity(0.4))
                    .bold()
                
                ExpandingTextView(text: self.$medicineVM.medicineEntryVM.medicineName)
                
                Text("Dosage:")
                    .font(.footnote)
                    .foregroundColor(Color.black.opacity(0.4))
                    .bold()
                
                ExpandingTextView(text: self.$medicineVM.medicineEntryVM.dosage)
        
                BubbledSelector(title: "Intake Timings",array: foodSelectionArray, selected: $medicineVM.medicineEntryVM.intake, limitToFour: checkToLimitTo4(arr: foodSelectionArray))
                
                BubbledSelector(title: "Route of Admission",array: routeOfAdmissionArray, selected: $medicineVM.medicineEntryVM.routeOfAdmin, limitToFour: checkToLimitTo4(arr: routeOfAdmissionArray))
                
                BubbledSelector(title: "Frequency",array: medicineInTakeTimings, selected: $medicineVM.medicineEntryVM.frequency, limitToFour: checkToLimitTo4(arr: medicineInTakeTimings))
                
                LargeButton(title: "Add Medicine") {
                    medicineVM.makeMedicineObjAndAdd()
                }
            }
        }
        .padding()
    }
    
    func checkToLimitTo4(arr:[String]) -> Bool {
        return arr.count > 4 ? true : false
    }
}
