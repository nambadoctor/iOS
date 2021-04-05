//
//  PrescriptionsView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 25/03/21.
//

import SwiftUI

struct PrescriptionsView: View {
    
    @ObservedObject var prescriptionsVM:MedicineViewModel
    var body: some View {
        prescriptions
    }
    
    var prescriptions : some View {
        VStack (alignment: .leading) {
            
            Text("PRESCRIPTION:")
                .font(.footnote)
                .foregroundColor(Color.black.opacity(0.4))
                .bold()

            ForEach (prescriptionsVM.prescription.medicineList, id: \.medicineName) { medicine in
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
                            prescriptionsVM.editPrescription(medicine: medicine)
                        } label: {
                            Image("pencil")
                                .foregroundColor(Color.blue)
                        }
                        
                        Button {
                            prescriptionsVM.removePrescription(medicine: medicine)
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

            LocalPickedImageDisplayView(imagePickerVM: prescriptionsVM.imagePickerVM)
            
            if !prescriptionsVM.prescription.fileInfo.MediaImage.isEmpty {
                HStack {
                    Spacer()
                    ImageView(withURL: prescriptionsVM.prescription.fileInfo.MediaImage)
                        .frame(width: 150, height: 200)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                    Spacer()
                }
            }


            HStack {
                
                LargeButton(title: "Add Manually",
                            backgroundColor: Color.white,
                            foregroundColor: Color.blue) {
                    prescriptionsVM.uploadManually()
                }
                .sheet(isPresented: $prescriptionsVM.showMedicineEntrySheet) {
                    MedicineEntryView(medicineVM: prescriptionsVM)
                }
                
                LargeButton(title: "Upload Image",
                            backgroundColor: Color.blue) {
                    prescriptionsVM.imagePickerVM.showActionSheet()
                }
                .modifier(ImagePickerModifier(imagePickerVM: self.prescriptionsVM.imagePickerVM))
            }
        }
    }
    
    var closeButton : some View {
        ZStack {
            if prescriptionsVM.imagePickerVM.image != nil || !prescriptionsVM.prescription.fileInfo.MediaImage.isEmpty {
                VStack (alignment: .center) {
                        HStack {
                            Spacer()
                            Button {
                                prescriptionsVM.imagePickerVM.image = nil
                                prescriptionsVM.prescription.fileInfo.MediaImage = ""
                            } label: {
                                Image("xmark.circle")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.blue)
                            }.padding()
                        }
                        Spacer()
                }.frame(width: 165, height: 215)
            }
        }
    }
}
