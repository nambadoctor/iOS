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

                MedicineValuesEntry(medicineEntryVM: self.medicineVM.medicineEntryVM)
            }
        }
        .onTapGesture { EndEditingHelper.endEditing() }
        .padding()
    }

}

struct MedicineValuesEntry : View {
    @ObservedObject var medicineEntryVM:MedicineEntryViewModel
    var body: some View {
        VStack (alignment: .leading, spacing: 15) {
            
            VStack (alignment: .leading) {
                Text("MEDICINE NAME")
                    .font(.footnote)
                    .foregroundColor(Color.black.opacity(0.4))
                    .bold()
                
                HStack {
                    PredictingTextField(predictableValues: self.$medicineEntryVM.autofillMedicineList, predictedValues: self.$medicineEntryVM.predictedMedicineList, textFieldInput: self.$medicineEntryVM.medicineName, changeDelegate: self.medicineEntryVM)
                    
                    if self.medicineEntryVM.medicineNameChanged {
                        Button {
                            self.medicineEntryVM.makeNewMedicine()
                        } label: {
                            Text("Confirm")
                        }
                    }
                }
                
                if self.medicineEntryVM.showPredictedMedicines {
                    VStack (spacing: 5) {
                        ForEach(self.medicineEntryVM.predictedMedicineList, id: \.AutofillMedicineId) {med in
                            VStack (alignment: .leading) {
                                HStack{Spacer()}
                                Text("\(med.MedicineBrandName) \(med.Dosage.Name) \(med.Dosage.Unit)")
                                    .foregroundColor(Color.blue)
                            }
                            .padding(7)
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(7)
                            .onTapGesture {
                                self.medicineEntryVM.autoSelectMedicine(medicine: med)
                            }
                        }
                    }
                }
            }

            if medicineEntryVM.medicineNameConfirmed {
                
                VStack (alignment: .leading) {
                    Text("DOSAGE")
                        .font(.footnote)
                        .foregroundColor(Color.black.opacity(0.4))
                        .bold()
                    
                    ExpandingTextView(text: self.$medicineEntryVM.dosage.Name)
                }

                VStack (alignment: .leading) {
                    Text("DURATION")
                        .font(.footnote)
                        .foregroundColor(Color.black.opacity(0.4))
                        .bold()
                    
                    ExpandingTextView(text: self.$medicineEntryVM.duration.Days, keyboardType: .numberPad)
                    
                    ThreeItemCheckBox(isChecked: self.$medicineEntryVM.duration.Unit, title1: "Days", title2: "Weeks", title3: "Months", delegate: self.medicineEntryVM)

                }
                
                BubbledSelector(title: "INTAKE TIMINGS",array: foodSelectionArray, selected: $medicineEntryVM.intake, limitToFour: checkToLimitTo4(arr: foodSelectionArray))
                
                BubbledSelector(title: "ROUTE OF ADMISSION",array: routeOfAdmissionArray, selected: $medicineEntryVM.routeOfAdmin, limitToFour: checkToLimitTo4(arr: routeOfAdmissionArray))
                
                VStack (alignment: .leading) {
                    Text("FREQUENCY")
                        .font(.footnote)
                        .foregroundColor(Color.black.opacity(0.4))
                        .bold()
                    
                    FrequencyPicker(medicineEntryVM: self.medicineEntryVM)
                }

                VStack (alignment: .leading) {
                    Text("INSTRUCTIONS (IF ANY)")
                        .font(.footnote)
                        .foregroundColor(Color.black.opacity(0.4))
                        .bold()
                    
                    ExpandingTextView(text: self.$medicineEntryVM.notes)
                }
                
                MedEntryAddButton(medicineEntryVM: medicineEntryVM)
            }
        }
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
            if medicineEntryVM.dosage.Name .isEmpty || medicineEntryVM.medicineName.isEmpty {
                if medicineEntryVM.showEmptyWarningText {
                    Text("PLEASE FILL MEDICINE NAME AND DOSAGE")
                        .font(.footnote)
                        .foregroundColor(Color.red.opacity(0.5))
                }
                LargeButton(title: "Save Medicine", disabled: false, backgroundColor: .gray, foregroundColor: .white) {
                    medicineEntryVM.toggleEmptyWarning()
                }
            } else {
                LargeButton(title: "Save Medicine") {
                    medicineEntryVM.makeMedObjAndAdd()
                }
            }
        }
    }
}
