//
//  DoctorConfigurableEntryFieldsViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 8/24/21.
//

import Foundation

class DoctorConfigurableEntryFieldsViewModel : ObservableObject {
    @Published var entryFields:ServiceProviderConfigurableEntryFields = ServiceProviderConfigurableEntryFields(Examination: true, Diagnosis: true, Investigations: true, Weight: false, Prescriptions: true, Advice: true, BloodPressure: false, BloodSugar: false, Height: false, MenstrualHistory: false, ObstetricHistory: false, IsSmokerOrAlcoholic: false, Menarche: false, Periods: false, AgeAtFirstChildBirth: false, LMP: false, NoOfChildren: false, BreastFeeding: false, FamilyHistoryOfCancer: false, OtherCancers: false, Diabetes: false, Hypertension: false, Asthma: false, Thyroid: false, Medication: false, DietAndAppetite: false, Habits: false, BreastExamination: false)
    
    init() {
        ServiceProviderProfileService().getServiceProviderConfigurableEntryFields(serviceProviderId: UserIdHelper().retrieveUserId()) { fields in
            if fields != nil {
                self.entryFields = fields!
            }
        }
    }
    
    func confirmSettings () {
        ServiceProviderProfileService().setServiceProviderConfigurableEntryFields(entryFields: entryFields) { success in
            
        }
    }
}
