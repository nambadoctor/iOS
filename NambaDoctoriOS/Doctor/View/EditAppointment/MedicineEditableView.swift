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
            
            Text("PRESCRIPTION:")
                .font(.footnote)
                .foregroundColor(Color.black.opacity(0.4))
                .bold()

            ForEach (medicineVM.prescription.medicineList, id: \.medicineName) { medicine in
                HStack {
                    VStack (alignment: .leading, spacing: 5) {
                        Text("\(medicine.medicineName) - \(medicine.dosage)")
                            .font(.callout)
                            .bold()
                            .foregroundColor(Color.green)
                        
                        if !medicine.routeOfAdministration.isEmpty {
                            Text("\(medicine.routeOfAdministration)")
                                .font(.callout)
                                .foregroundColor(Color.green)
                        }
                        
                        if !medicine.intake.isEmpty {
                            Text("\(medicine.intake)")
                                .font(.callout)
                                .foregroundColor(Color.green)
                        }
                        
                        if !medicine.specialInstructions.isEmpty {
                            Text("\(medicine.specialInstructions)")
                                .font(.callout)
                                .foregroundColor(Color.green)
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
                                .foregroundColor(Color.blue)
                        }
                    }
                    
                }
                .padding()
                .background(Color.green.opacity(0.1))
                .cornerRadius(7)
            }

            //MARK:- TODO: NEED TO FIX OVERLAPPING DISPLAYS AND CONVERSION INTO VIEW MEDICINE
            LocalPickedImageDisplayView(imagePickerVM: medicineVM.imagePickerVM)

            if !medicineVM.prescription.fileInfo.MediaImage.isEmpty {
                HStack {
                    Spacer()
                    ImageView(withURL: medicineVM.prescription.fileInfo.MediaImage)
                        .frame(width: 150, height: 200)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                    Spacer()
                }
            }
            //MARK:- END TODO

            HStack {
                LargeButton(title: "Add Manually",
                            backgroundColor: Color.white,
                            foregroundColor: Color.blue) {
                    medicineVM.uploadManually()
                }
                .sheet(isPresented: $medicineVM.showMedicineEntrySheet) {
                    MedicineEntryView()
                }
                
                LargeButton(title: "Upload Image",
                            backgroundColor: Color.blue) {
                    medicineVM.imagePickerVM.showActionSheet()
                }
                .modifier(ImagePickerModifier(imagePickerVM: self.medicineVM.imagePickerVM))
            }
        }
    }
}
