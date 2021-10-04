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
                            LoggerService().log(eventName: "Edit already entered medicine")
                            medicineVM.editPrescription(medicine: medicine)
                        } label: {
                            Image("pencil")
                                .foregroundColor(Color.blue)
                        }
                        
                        Button {
                            LoggerService().log(eventName: "Remove already entered medicine")
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
            
            ScrollView (.horizontal) {
                HStack {
                    if medicineVM.imageLoader != nil {
                        ImageView(imageLoader: medicineVM.imageLoader!)
                    }
                    
                    if medicineVM.imageLoaders != nil {
                        ForEach (self.medicineVM.imageLoaders!, id: \.id) { loader in
                            ZStack {
                                ImageView(imageLoader: loader)
                                VStack {
                                    HStack {
                                        Spacer()
                                        Image("xmark.circle")
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                            .foregroundColor(.red)
                                    }
                                    Spacer()
                                }.onTapGesture {
                                    self.medicineVM.removeImage(imageToRemove: loader)
                                }
                            }
                        }
                    }
                    
                    MultipleLocalPickedImageDisplayView(imagePickerVM: medicineVM.imagePickerVM)
                }
            }
            
            HStack {
                LargeButton(title: "Add Medicine",
                            backgroundColor: Color.white,
                            foregroundColor: Color.blue) {
                    LoggerService().log(eventName: "Add new medicine")
                    medicineVM.uploadManually()
                }
                            .sheet(isPresented: $medicineVM.showMedicineEntrySheet) {
                                MedicineEntryView(medicineVM: medicineVM)
                            }
                
                LargeButton(title: "Upload Images",
                            backgroundColor: Color.blue) {
                    LoggerService().log(eventName: "Upload image")
                    
                    if self.medicineVM.imagePickerVM.images != nil {
                        LoggerService().log(eventName: "Trying to upload image with existing image (maybe trying for multiple image upload)")
                    }
                    medicineVM.imagePickerVM.showActionSheet()
                }
                            .modifier(MultipleImagePickerModifier(imagePickerVM: self.medicineVM.imagePickerVM))
                
            }
        }
    }
}
