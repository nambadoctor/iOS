//
//  EditConfigurableEntryFieldsView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 8/24/21.
//

import SwiftUI

struct EditConfigurableEntryFieldsView: View {
    @ObservedObject var configurableEntryVM:DoctorConfigurableEntryFieldsViewModel
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("General")) {
                    Toggle("Examination", isOn: self.$configurableEntryVM.entryFields.Examination)
                    Toggle("Diagnosis", isOn: self.$configurableEntryVM.entryFields.Diagnosis)
                    Toggle("Investigations", isOn: self.$configurableEntryVM.entryFields.Investigations)
                    Toggle("Prescriptions", isOn: self.$configurableEntryVM.entryFields.Prescriptions)
                    Toggle("Advice", isOn: self.$configurableEntryVM.entryFields.Advice)
                }

                Section(header: Text("Patient Vitals")) {
                    Toggle("Weight", isOn: self.$configurableEntryVM.entryFields.Weight)
                    Toggle("BloodPressure", isOn: self.$configurableEntryVM.entryFields.BloodPressure)
                    Toggle("BloodSugar", isOn: self.$configurableEntryVM.entryFields.BloodSugar)
                    Toggle("Height", isOn: self.$configurableEntryVM.entryFields.Height)
                    Toggle("IsSmokerOrAlcoholic", isOn: self.$configurableEntryVM.entryFields.IsSmokerOrAlcoholic)
                }
                
                Section(header: Text("Breast Cancer Related")) {
                    Toggle("MenstrualHistory", isOn: self.$configurableEntryVM.entryFields.MenstrualHistory)
                    Group {
                        Toggle("ObstetricHistory", isOn: self.$configurableEntryVM.entryFields.ObstetricHistory)
                        Toggle("Menarche", isOn: self.$configurableEntryVM.entryFields.Menarche)
                        Toggle("Periods", isOn: self.$configurableEntryVM.entryFields.Periods)
                        Toggle("AgeAtFirstChildBirth", isOn: self.$configurableEntryVM.entryFields.AgeAtFirstChildBirth)
                        Toggle("LMP", isOn: self.$configurableEntryVM.entryFields.LMP)
                        Toggle("NoOfChildren", isOn: self.$configurableEntryVM.entryFields.NoOfChildren)
                        Toggle("BreastFeeding", isOn: self.$configurableEntryVM.entryFields.BreastFeeding)
                        Toggle("FamilyHistoryOfCancer", isOn: self.$configurableEntryVM.entryFields.FamilyHistoryOfCancer)
                        Toggle("OtherCancers", isOn: self.$configurableEntryVM.entryFields.OtherCancers)
                    }
                    
                    Group {
                        Toggle("Diabetes", isOn: self.$configurableEntryVM.entryFields.Diabetes)
                        Toggle("Hypertension", isOn: self.$configurableEntryVM.entryFields.Hypertension)
                        Toggle("Asthma", isOn: self.$configurableEntryVM.entryFields.Asthma)
                        Toggle("Thyroid", isOn: self.$configurableEntryVM.entryFields.Thyroid)
                        Toggle("Medication", isOn: self.$configurableEntryVM.entryFields.Medication)
                        Toggle("DietAndAppetite", isOn: self.$configurableEntryVM.entryFields.DietAndAppetite)
                        Toggle("BreastExamination", isOn: self.$configurableEntryVM.entryFields.BreastExamination)
                    }
                }
            }
            .navigationBarTitle(Text("Entry Field Settings"), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                self.configurableEntryVM.confirmSettings()
            }, label: {
                Text("Done")
            }))
        }
    }
}
