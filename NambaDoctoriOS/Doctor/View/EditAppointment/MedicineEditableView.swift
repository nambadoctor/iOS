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
            
            Text("PRESCRIPTION")
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
                        
                        if medicine.duration != 0 {
                            Text("\(medicine.duration) days")
                                .font(.callout)
                                .foregroundColor(Color.green)
                        } else {
                            Text("No duration specified")
                                .font(.callout)
                                .foregroundColor(Color.green)
                        }
                        
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
                        
                        if !medicine.timings.isEmpty {
                            Text("\(medicine.timings)")
                                .font(.callout)
                                .foregroundColor(Color.green)
                        } else {
                            Text("Take whenever necessary")
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

            ZStack {
                if medicineVM.imageLoader != nil && !medicineVM.localImageSelected {
                    HStack {
                        Spacer()
                        ImageView(imageLoader: medicineVM.imageLoader!)
                        Spacer()
                    }
                    CloseButton {
                        self.medicineVM.removeLoadedImage()
                    }
                } else if medicineVM.localImageSelected {
                    LocalPickedImageDisplayView(imagePickerVM: medicineVM.imagePickerVM)
                }
            }
    
            HStack {
                LargeButton(title: "Add Manually",
                            backgroundColor: Color.white,
                            foregroundColor: Color.blue) {
                    medicineVM.uploadManually()
                }
                .sheet(isPresented: $medicineVM.showMedicineEntrySheet) {
                    MedicineEntryView()
                        .environmentObject(medicineVM)
                }
                
                if medicineVM.localImageSelected {
                    LargeButton(title: "Remove Image",
                                backgroundColor: Color.red) {
                        medicineVM.localImageSelected = false
                        medicineVM.imagePickerVM.removeImage()
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

struct CloseButton : View {
    
    private let action: () -> Void
    
    init(action: @escaping () -> Void) {
        self.action = action
    }
    
    var body: some View {
        VStack{
            HStack {
                Spacer()
                Button(action:self.action) {
                    Image("xmark.circle")
                        .resizable()
                        .frame(width: 35, height: 35)
                        .foregroundColor(.blue)
                }.padding()
            }
            Spacer()
        }
    }
}
