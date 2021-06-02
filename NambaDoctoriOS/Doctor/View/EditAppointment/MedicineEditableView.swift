//
//  MedicineEditableView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/5/21.
//

import SwiftUI

struct MedicineEditableView: View {
    
    @EnvironmentObject var medicineVM:MedicineViewModel
    
    var body: some View {
        VStack (alignment: .leading) {
            
            HStack (spacing: 3) {
                Image("pills")
                    .modifier(DetailedAppointmentViewIconModifier())
                
                Text("PRESCRIPTION")
                    .font(.footnote)
                    .foregroundColor(Color.black.opacity(0.4))
                    .bold()
            }

            ForEach (medicineVM.prescription.medicineList, id: \.medicineID) { medicine in
                HStack {
                    VStack (alignment: .leading, spacing: 5) {
                        Text("\(medicine.medicineName)")
                            .font(.callout)
                            .bold()
                            .foregroundColor(Color.blue)
                        
                        Text("\(medicine.intakeDosage.Name) \(medicine.intakeDosage.Unit)")
                            .font(.callout)
                            .foregroundColor(Color.blue)
                        
                        if !medicine.specialInstructions.isEmpty {
                            Text("\(medicine.specialInstructions)")
                                .font(.callout)
                                .foregroundColor(Color.blue)
                        }
                        
                        if !medicine.routeOfAdministration.isEmpty {
                            Text("\(medicine.routeOfAdministration)")
                                .font(.callout)
                                .foregroundColor(Color.blue)
                        }
                        
                        if !medicine.intake.isEmpty {
                            Text("\(medicine.intake)")
                                .font(.callout)
                                .foregroundColor(Color.blue)
                        }
                        
                        if !medicine.timings.isEmpty {
                            Text("\(medicine.timings)")
                                .font(.callout)
                                .foregroundColor(Color.blue)
                        }
                        
                        if !medicine._duration.Days.isEmpty {
                            Text("\(medicine._duration.Days) \(medicine._duration.Unit)")
                                .font(.callout)
                                .foregroundColor(Color.blue)
                        } else {
                            Text("No duration specified")
                                .font(.callout)
                                .foregroundColor(Color.blue)
                        }
                        
                        if !medicine.notes.isEmpty {
                            Text("\(medicine.notes)")
                                .font(.callout)
                                .foregroundColor(Color.blue)
                        }
                    }
                    Spacer()
                    
                    VStack (spacing: 15) {
                        Button {
                            medicineVM.editPrescription(medicine: medicine)
                        } label: {
                            Image("pencil")
                                .foregroundColor(Color.blue)
                        }
                        
                        Button {
                            medicineVM.removePrescription(medicine: medicine)
                        } label: {
                            Image("xmark.circle")
                                .foregroundColor(Color.red)
                        }
                    }
                }
                .padding()
                .background(Color.blue.opacity(0.08))
                .cornerRadius(7)
            }

            ZStack {
                if medicineVM.imageLoader != nil && !medicineVM.localImageSelected {
                    HStack {
                        Spacer()
                        ImageView(imageLoader: medicineVM.imageLoader!)
                        Spacer()
                    }
                } else if medicineVM.localImageSelected {
                    LocalPickedImageDisplayView(imagePickerVM: medicineVM.imagePickerVM)
                }
            }

            HStack {
                LargeButton(title: "Add Medicine",
                            backgroundColor: Color.white,
                            foregroundColor: Color.blue) {
                    medicineVM.uploadManually()
                }
                .sheet(isPresented: $medicineVM.showMedicineEntrySheet) {
                    MedicineEntryView()
                        .environmentObject(medicineVM)
                }
                
                if medicineVM.showRemoveButton {
                    LargeButton(title: "Remove Image",
                                backgroundColor: Color.red) {
                        self.medicineVM.removeSelectImage()
                        self.medicineVM.removeLoadedImage()
                    }
                    .modifier(ImagePickerModifier(imagePickerVM: self.medicineVM.imagePickerVM))
                } else {
                    LargeButton(title: "Upload Image",
                                backgroundColor: Color.blue) {
                        medicineVM.imagePickerVM.showActionSheet()
                    }
                    .modifier(ImagePickerModifier(imagePickerVM: self.medicineVM.imagePickerVM))
                }
            }
        }
    }
}
