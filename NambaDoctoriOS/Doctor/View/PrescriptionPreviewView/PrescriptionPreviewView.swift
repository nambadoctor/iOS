//
//  PrescriptionPreviewView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/18/21.
//

import SwiftUI

struct PrescriptionPreviewView: View {
    
    @EnvironmentObject var intermediateVM:IntermediateAppointmentViewModel
    
    var body: some View {
        VStack {

            HStack {
                Text("Prescription Preview")
                    .font(.title)
                    .bold()
                Spacer()
                Button {
                    self.intermediateVM.showPDFPreview = false
                } label: {
                    Image("xmark.circle")
                        .resizable()
                        .frame(width: 35, height: 35)
                        .foregroundColor(.blue)
                }
            }
            .padding()

            DoctorPrescriptionPreviewHelper()
        }
        .onAppear() {intermediateVM.medicineVM.retrievePrescriptions()}
    }
}

struct DoctorPrescriptionPreviewHelper : View {
    
    @EnvironmentObject var medicineVM:MedicineViewModel
    
    var body: some View {
        if medicineVM.prescription.medicineList.count > 0 {
            if  medicineVM.prescriptionPDF != nil {
                PDFKitRepresentedView(medicineVM.prescriptionPDF!)
            }
        } else {
            ScrollView {
                MedicineView()
                    .background(Color.white)
                
                ServiceRequestView()
                    .background(Color.white)
                
                InvestigationsView()
                    .background(Color.white)
            }
        }
        
        Spacer()
    }
}
