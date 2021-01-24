//
//  MedicineEntryView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 22/01/21.
//

import SwiftUI

struct MedicineEntryView: View {
    
    @ObservedObject var medicineVM:MedicineViewModel
    @ObservedObject var medicineEntryVM:MedicineEntryViewModel
    
    init(medicineViewModel:MedicineViewModel) {
        self.medicineVM = medicineViewModel
        self.medicineEntryVM = medicineViewModel.medicineEntryVM
    }
    
    var body: some View {
        NavigationView {
            Form {
                basicDetails
                timingDetails
                durationDetails
                timingQuantity
                
                Section {
                    doneButton
                    cancelButton
                }
            }.navigationBarTitle("Prescription Entry")
        }
        .alert(isPresented: $medicineVM.showLocalAlert, content: {
            return Alert(title: alertTempItem!.title, message: alertTempItem!.message, dismissButton: alertTempItem!.dismissButton)
        })
    }

    var basicDetails : some View {
        Section(header: Text("Basic Details")) {
            TextField("Medicine Name", text: $medicineEntryVM.medicineName)
            TextField("Dosage", text: $medicineEntryVM.dosage)
            
            Picker(selection: $medicineEntryVM.routeOfAdminIndex, label: Text("Route of Administration")) {
                ForEach(0 ..< routeOfAdmissionArray.count) {
                    Text(routeOfAdmissionArray[$0])
                }
            }
        }
    }
    
    var timingDetails : some View {
        Section(header: Text("Timing Details")) {
            Picker(selection: $medicineEntryVM.foodSelectionIndex, label: Text("Time To Be Taken")) {
                ForEach(0 ..< foodSelectionArray.count) {
                    Text(foodSelectionArray[$0])
                }
            }
            
            Picker(selection: $medicineEntryVM.inTakeIndex, label: Text("Intake Timings")) {
                ForEach(0 ..< medicineInTakeTimings.count) {
                    Text(medicineInTakeTimings[$0])
                }
            }
        }
    }
    
    var durationDetails : some View {
        Section(header: Text("Duration of Prescription")) {
            if !medicineEntryVM.noSpecificDuration {
                HStack {
                    TextField("Duration", text: $medicineEntryVM.tempNumOfDays).keyboardType(.numberPad)
                    Picker(selection: $medicineEntryVM.timeIndex, label: Text("")) {
                        ForEach(0 ..< timeOptions.count) {
                            Text(timeOptions[$0])
                        }
                    }
                }
            }
            
            Toggle(isOn: $medicineEntryVM.noSpecificDuration) {
                Text("No Specific Duration")
            }
        }
    }

    var timingQuantity : some View {
        Section(header: Text("Quantity")) {
            Stepper(value: $medicineEntryVM.morningTemp, in: 0...10, step: 0.5) {
                Text("Morning: \(medicineVM.morningQuanityDisplay)")
            }
            Stepper(value: $medicineEntryVM.noonTemp, in: 0...10, step: 0.5) {
                Text("Afternoon: \(medicineVM.noonQuanityDisplay)")
            }
            Stepper(value: $medicineEntryVM.eveningTemp, in: 0...10, step: 0.5) {
                Text("Evening: \(medicineVM.eveQuanityDisplay)")
            }
            Stepper(value: $medicineEntryVM.nightTemp, in: 0...10, step: 0.5) {
                Text("Night: \(medicineVM.nightQuanityDisplay)")
            }
        }
    }

    var doneButton : some View {
        Button(action: {
            medicineVM.finishWritingMedicine(isNewMedicine: medicineEntryVM.isNewMedicine)
        }) {
            HStack {
                Spacer()
                Text("Done").foregroundColor(Color.white)
                Spacer()
            }.padding(12).background(Color(UIColor.green)).cornerRadius(4)
        }
    }

    var cancelButton : some View {
        Button(action: {
            medicineVM.dismissMedicineEntrySheet()
        }) {
            HStack {
                Spacer()
                Text("Cancel").foregroundColor(Color.white)
                Spacer()
            }.padding(12).background(Color(UIColor.red)).cornerRadius(4)
        }
    }

}
