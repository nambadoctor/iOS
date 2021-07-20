//
//  MedicineEntryView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 26/03/21.
//

import SwiftUI

struct MedicineEntryView: View {
    @ObservedObject var medicineVM:MedicineViewModel
    
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
                    .foregroundColor(self.medicineEntryVM.invalidMedNameAttempt == 0 ? Color.black.opacity(0.4) : Color.red)
                    .bold()
                    .modifier(Shake(animatableData: CGFloat(self.medicineEntryVM.invalidMedNameAttempt)))

                HStack {
                    PredictingTextField(predictableValues: self.$medicineEntryVM.autoFillVM.autofillMedicineList, predictedValues: self.$medicineEntryVM.autoFillVM.predictedMedicineList, textFieldInput: self.$medicineEntryVM.medicineName, changeDelegate: self.medicineEntryVM.changed, isFirstResponder: self.$medicineEntryVM.isFirstResponder)
                    
                    if self.medicineEntryVM.medicineNameChanged {
                        Button {
                            self.medicineEntryVM.makeNewMedicine()
                        } label: {
                            Text("Confirm")
                        }
                    }
                }

                if self.medicineEntryVM.showPredictedMedicines {
                    LazyVStack (spacing: 5) {
                        ForEach(self.medicineEntryVM.autoFillVM.predictedMedicineList, id: \.AutofillMedicineId) {med in
                            VStack (alignment: .leading) {
                                HStack{Spacer()}
                                Text(med.BrandName)
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
                    HStack {
                        Text("DOSAGE")
                            .font(.footnote)
                            .foregroundColor(self.medicineEntryVM.invalidDosageAttempt == 0 ? Color.black.opacity(0.4) : Color.red)
                            .bold()
                        Text("(E.g 1 tab, 5 ml, etc...)")
                            .font(.subheadline)
                            .foregroundColor(self.medicineEntryVM.invalidDosageAttempt == 0 ? Color.black : Color.red)
                            .bold()
                    }
                    .modifier(Shake(animatableData: CGFloat(self.medicineEntryVM.invalidDosageAttempt)))
                    
                    ExpandingTextEntryView(text: self.$medicineEntryVM.dosage.Name)
                }
                
                VStack (alignment: .leading) {
                    Text("FREQUENCY")
                        .font(.footnote)
                        .foregroundColor(Color.black.opacity(0.4))
                        .bold()

                    FrequencyPicker(medicineEntryVM: self.medicineEntryVM)
                }
                
                BubbledSelector(title: "ROUTE OF ADMINISTRATION",array: routeOfAdministrationArray, selected: $medicineEntryVM.routeOfAdmin, limitToFour: checkToLimitTo4(arr: routeOfAdministrationArray))
                
                BubbledSelector(title: "INTAKE TIMINGS",array: foodSelectionArray, selected: $medicineEntryVM.intake, limitToFour: checkToLimitTo4(arr: foodSelectionArray))

                VStack (alignment: .leading) {
                    Text("DURATION")
                        .font(.footnote)
                        .foregroundColor(Color.black.opacity(0.4))
                        .bold()
                    
                    HStack {
                        ExpandingTextEntryView(text: self.$medicineEntryVM.duration.Days, keyboardType: .numberPad)

                        Menu {
                            
                            Button {
                                self.medicineEntryVM.duration.Unit = "Days"
                            } label: {
                                
                                Text("Days")
                            }
                            
                            Button {
                                self.medicineEntryVM.duration.Unit = "Weeks"
                            } label: {
                                
                                Text("Weeks")
                            }
                            
                            Button {
                                self.medicineEntryVM.duration.Unit = "Months"
                            } label: {
                                Text("Months")
                            }
                            
                        } label: {
                            Text(self.medicineEntryVM.duration.Unit)
                            Image("chevron.down.circle")
                        }
                    }
                }

                VStack (alignment: .leading) {
                    Text("INSTRUCTIONS (IF ANY)")
                        .font(.footnote)
                        .foregroundColor(Color.black.opacity(0.4))
                        .bold()
                    
                    ExpandingTextEntryView(text: self.$medicineEntryVM.notes)
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
        VStack (alignment: .leading, spacing: 8) {
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
                Text("Take as Needed")
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
        HStack {
            CustomStepperBox(number: $medicineEntryVM.morning, displayName: "Morn.", imageName: "sunrise.fill")
            CustomStepperBox(number: $medicineEntryVM.afternoon, displayName: "Aft.", imageName: "sun.max.fill")
            CustomStepperBox(number: $medicineEntryVM.night, displayName: "Nig.", imageName: "moon.stars.fill")
        }
    }
}

struct MedEntryAddButton : View {
    @ObservedObject var medicineEntryVM:MedicineEntryViewModel
    
    var body: some View {
        LargeButton(title: "Save Medicine") {
            medicineEntryVM.makeMedObjAndAdd()
        }
    }
}
