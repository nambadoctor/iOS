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
                
                Text("MEDICINE NAME")
                    .font(.footnote)
                    .foregroundColor(Color.black.opacity(0.4))
                    .bold()
                
                ExpandingTextView(text: self.$medicineVM.medicineEntryVM.medicineName)
                
                Text("DOSAGE")
                    .font(.footnote)
                    .foregroundColor(Color.black.opacity(0.4))
                    .bold()
                
                ExpandingTextView(text: self.$medicineVM.medicineEntryVM.dosage)
        
                BubbledSelector(title: "Intake Timings",array: foodSelectionArray, selected: $medicineVM.medicineEntryVM.intake, limitToFour: checkToLimitTo4(arr: foodSelectionArray))
                
                BubbledSelector(title: "Route of Admission",array: routeOfAdmissionArray, selected: $medicineVM.medicineEntryVM.routeOfAdmin, limitToFour: checkToLimitTo4(arr: routeOfAdmissionArray))
                
                BubbledSelector(title: "Frequency",array: medicineInTakeTimings, selected: $medicineVM.medicineEntryVM.frequency, limitToFour: checkToLimitTo4(arr: medicineInTakeTimings))
                
                MedEntryAddButton(medicineEntryVM: medicineVM.medicineEntryVM)
                
            }
        }
        .onTapGesture { EndEditingHelper.endEditing() }
        .padding()
    }
    
    func checkToLimitTo4(arr:[String]) -> Bool {
        return arr.count > 4 ? true : false
    }
}

struct MedEntryAddButton : View {
    @ObservedObject var medicineEntryVM:MedicineEntryViewModel
    
    var body: some View {
        VStack {
            if medicineEntryVM.dosage.isEmpty || medicineEntryVM.medicineName.isEmpty {
                if medicineEntryVM.showEmptyWarningText {
                    Text("PLEASE FILL MEDICINE NAME AND DOSAGE")
                        .font(.footnote)
                        .foregroundColor(Color.red.opacity(0.5))
                }
                LargeButton(title: "Add Medicine", disabled: false, backgroundColor: .gray, foregroundColor: .white) {
                    medicineEntryVM.toggleEmptyWarning()
                }
            } else {
                LargeButton(title: "Add Medicine") {
                    medicineEntryVM.makeMedObjAndAdd()
                }
            }
        }
    }
}
