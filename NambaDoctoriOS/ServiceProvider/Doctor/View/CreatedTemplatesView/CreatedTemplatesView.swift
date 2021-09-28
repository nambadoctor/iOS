//
//  CreatedTemplatesView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 9/22/21.
//

import SwiftUI

struct CreatedTemplatesView: View {
    @ObservedObject var intermediateVM:IntermediateAppointmentViewModel
    
    var body: some View {
        Form {
            
            TextField("Template Name", text: self.$intermediateVM.templateName)
            
            Text("Advice: \(self.intermediateVM.makeTemplate().advice)")
            Text("Diagnosis: \(self.intermediateVM.makeTemplate().diagnosis.name)")
            
            Section(header: Text("Investigations")) {
                ForEach(self.intermediateVM.makeTemplate().investigations, id: \.self) { investigation in
                    Text(investigation)
                }
            }
            
            Section(header: Text("Medicines")) {
                MedicineView()
                    .environmentObject(self.intermediateVM.medicineVM)
            }
            
            Button {
                self.intermediateVM.saveAsNewTemplate()
            } label: {
                Text("Confirm")
            }
        }
    }
}
