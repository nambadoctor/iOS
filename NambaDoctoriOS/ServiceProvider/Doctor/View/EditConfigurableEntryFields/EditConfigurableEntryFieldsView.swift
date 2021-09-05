//
//  EditConfigurableEntryFieldsView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 8/24/21.
//

import SwiftUI

struct EditConfigurableEntryFieldsView: View {
    @ObservedObject var configurableEntryVM:DoctorConfigurableEntryFieldsViewModel
    @Binding var showSheet:Bool
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("General")) {
                    Toggle("Examination", isOn: self.$configurableEntryVM.selectedEntryField.Examination)
                    Toggle("Diagnosis", isOn: self.$configurableEntryVM.selectedEntryField.Diagnosis)
                    Toggle("Investigations", isOn: self.$configurableEntryVM.selectedEntryField.Investigations)
                    Toggle("Prescriptions", isOn: self.$configurableEntryVM.selectedEntryField.Prescriptions)
                    Toggle("Advice", isOn: self.$configurableEntryVM.selectedEntryField.Advice)
                }

                Section(header: Text("Patient Vitals")) {
                    Toggle("Weight", isOn: self.$configurableEntryVM.selectedEntryField.Weight)
                    Toggle("BloodPressure", isOn: self.$configurableEntryVM.selectedEntryField.BloodPressure)
                    Toggle("BloodSugar", isOn: self.$configurableEntryVM.selectedEntryField.BloodSugar)
                    Toggle("Height", isOn: self.$configurableEntryVM.selectedEntryField.Height)
                    Toggle("IsSmokerOrAlcoholic", isOn: self.$configurableEntryVM.selectedEntryField.IsSmokerOrAlcoholic)
                }
                
                Section(header: Text("Breast Cancer Related")) {
                    Toggle("MenstrualHistory", isOn: self.$configurableEntryVM.selectedEntryField.MenstrualHistory)
                    Group {
                        Toggle("ObstetricHistory", isOn: self.$configurableEntryVM.selectedEntryField.ObstetricHistory)
                        Toggle("Menarche", isOn: self.$configurableEntryVM.selectedEntryField.Menarche)
                        Toggle("Periods", isOn: self.$configurableEntryVM.selectedEntryField.Periods)
                        Toggle("AgeAtFirstChildBirth", isOn: self.$configurableEntryVM.selectedEntryField.AgeAtFirstChildBirth)
                        Toggle("LMP", isOn: self.$configurableEntryVM.selectedEntryField.LMP)
                        Toggle("NoOfChildren", isOn: self.$configurableEntryVM.selectedEntryField.NoOfChildren)
                        Toggle("BreastFeeding", isOn: self.$configurableEntryVM.selectedEntryField.BreastFeeding)
                        Toggle("FamilyHistoryOfCancer", isOn: self.$configurableEntryVM.selectedEntryField.FamilyHistoryOfCancer)
                        Toggle("OtherCancers", isOn: self.$configurableEntryVM.selectedEntryField.OtherCancers)
                    }
                    
                    Group {
                        Toggle("Diabetes", isOn: self.$configurableEntryVM.selectedEntryField.Diabetes)
                        Toggle("Hypertension", isOn: self.$configurableEntryVM.selectedEntryField.Hypertension)
                        Toggle("Asthma", isOn: self.$configurableEntryVM.selectedEntryField.Asthma)
                        Toggle("Thyroid", isOn: self.$configurableEntryVM.selectedEntryField.Thyroid)
                        Toggle("Medication", isOn: self.$configurableEntryVM.selectedEntryField.Medication)
                        Toggle("DietAndAppetite", isOn: self.$configurableEntryVM.selectedEntryField.DietAndAppetite)
                        Toggle("BreastExamination", isOn: self.$configurableEntryVM.selectedEntryField.BreastExamination)
                    }
                }
            }
            .navigationBarTitle(Text("Entry Field Settings"), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                self.configurableEntryVM.confirmSettings { success in
                    if success {
                        self.showSheet = false
                    }
                }
            }, label: {
                Text("Done")
            }))
        }
    }
}
