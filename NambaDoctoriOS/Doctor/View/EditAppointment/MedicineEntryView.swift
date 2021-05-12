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
            VStack (alignment: .leading, spacing: 20) {
                
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

                VStack (alignment: .leading) {
                    Text("MEDICINE NAME")
                        .font(.footnote)
                        .foregroundColor(Color.black.opacity(0.4))
                        .bold()
                    
                    ExpandingTextView(text: self.$medicineVM.medicineEntryVM.medicineName)
                }
                
                HStack {
                    VStack (alignment: .leading) {
                        Text("DOSAGE")
                            .font(.footnote)
                            .foregroundColor(Color.black.opacity(0.4))
                            .bold()
                        
                        ExpandingTextView(text: self.$medicineVM.medicineEntryVM.dosage)
                    }

                    VStack (alignment: .leading) {
                        Text("DURATION (days)")
                            .font(.footnote)
                            .foregroundColor(Color.black.opacity(0.4))
                            .bold()
                        
                        ExpandingTextView(text: self.$medicineVM.medicineEntryVM.duration, keyboardType: .numberPad)
                            
                    }
                }

                BubbledSelector(title: "INTAKE TIMINGS",array: foodSelectionArray, selected: $medicineVM.medicineEntryVM.intake, limitToFour: checkToLimitTo4(arr: foodSelectionArray))
                
                BubbledSelector(title: "ROUTE OF ADMISSION",array: routeOfAdmissionArray, selected: $medicineVM.medicineEntryVM.routeOfAdmin, limitToFour: checkToLimitTo4(arr: routeOfAdmissionArray))
                
                Text("FREQUENCY")
                    .font(.footnote)
                    .foregroundColor(Color.black.opacity(0.4))
                    .bold()
                
                FrequencyPicker(medicineEntryVM: self.medicineVM.medicineEntryVM)
                
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

struct FrequencyPicker : View {
    @ObservedObject var medicineEntryVM:MedicineEntryViewModel
    var body : some View {
        VStack (alignment: .leading) {
            HStack {
                if self.medicineEntryVM.wheneverNecessary {
                    Image("checkmark.square.fill")
                        .resizable()
                        .frame(width: 28.0, height: 28.0)
                        .foregroundColor(.blue)
                        .onTapGesture() {
                            self.medicineEntryVM.wheneverNecessary.toggle()
                        }
                } else {
                    Image("square")
                        .resizable()
                        .frame(width: 28.0, height: 28.0)
                        .onTapGesture() {
                            self.medicineEntryVM.wheneverNecessary.toggle()
                        }
                }
                Text("Only Take Whenever Necessary")
            }
            if !self.medicineEntryVM.wheneverNecessary {
                FrequencyPickerView(medicineEntryVM: self.medicineEntryVM)
            }
        }
    }
}

struct FrequencyPickerView : View {
    @ObservedObject var medicineEntryVM:MedicineEntryViewModel
    var twoColumnGrid = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: twoColumnGrid) {
                VStack (alignment: .leading) {
                    Text("morning")
                        .font(.footnote)
                        .foregroundColor(.black)
                    CustomStepperBox(number: $medicineEntryVM.morning)
                }
                
                VStack (alignment: .leading) {
                    Text("afternoon")
                        .font(.footnote)
                        .foregroundColor(.black)
                    CustomStepperBox(number: $medicineEntryVM.afternoon)
                }
                
                VStack (alignment: .leading) {
                    Text("evening")
                        .font(.footnote)
                        .foregroundColor(.black)
                    CustomStepperBox(number: $medicineEntryVM.evening)
                }

                VStack (alignment: .leading) {
                    Text("night")
                        .font(.footnote)
                        .foregroundColor(.black)
                    CustomStepperBox(number: $medicineEntryVM.night)
                }
            }
        }
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
