//
//  DoctorConfigurableEntryFieldsViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 8/24/21.
//

import Foundation

class DoctorConfigurableEntryFieldsViewModel : ObservableObject {
    @Published var selectedEntryField:ServiceProviderConfigurableEntryFields = ServiceProviderConfigurableEntryFields(Examination: true, Diagnosis: true, Investigations: true, Weight: false, Prescriptions: true, Advice: true, BloodPressure: false, BloodSugar: false, Height: false, MenstrualHistory: false, ObstetricHistory: false, IsSmokerOrAlcoholic: false, Menarche: false, Periods: false, AgeAtFirstChildBirth: false, LMP: false, NoOfChildren: false, BreastFeeding: false, FamilyHistoryOfCancer: false, OtherCancers: false, Diabetes: false, Hypertension: false, Asthma: false, Thyroid: false, Medication: false, DietAndAppetite: false, Habits: false, BreastExamination: false, Pulse: false, RespiratoryRate: false, Saturation: false, Temperature: true)
    
    @Published var entryFieldsList:[ServiceProviderConfigurableEntryFieldsObject] = [ServiceProviderConfigurableEntryFieldsObject]()
    
    @Published var showAdditionalFields:Bool = false

    var orgId:String
    var serviceProviderId:String
    
    init(orgId:String, serviceProviderId:String) {
        self.orgId = orgId
        self.serviceProviderId = serviceProviderId
        
        ServiceProviderProfileService().getServiceProviderConfigurableEntryFields(serviceProviderId: serviceProviderId) { fields in
            if fields != nil && !fields!.isEmpty {
                self.entryFieldsList = fields!
                self.confirmSettings(configuration: self.entryFieldsList[0]) { success in }
            }
        }
    }

    func confirmSettings (configuration:ServiceProviderConfigurableEntryFieldsObject, completion: @escaping (_ success:Bool)->()) {
        self.selectedEntryField = configuration.entryFields
        self.checkForAdditionalFields()
    }

    func fieldsForVitalsExist () -> Bool {
        if selectedEntryField.Weight || selectedEntryField.BloodPressure || selectedEntryField.BloodSugar || selectedEntryField.Height || selectedEntryField.MenstrualHistory || selectedEntryField.ObstetricHistory || selectedEntryField.IsSmokerOrAlcoholic {
            return true
        } else {
            return false
        }
    }
    
    func checkForAdditionalFields () {
        if self.selectedEntryField.Menarche || self.selectedEntryField.Periods || self.selectedEntryField.AgeAtFirstChildBirth || self.selectedEntryField.LMP || self.selectedEntryField.NoOfChildren || self.selectedEntryField.BreastFeeding || self.selectedEntryField.FamilyHistoryOfCancer || self.selectedEntryField.OtherCancers || self.selectedEntryField.Diabetes || self.selectedEntryField.Hypertension || self.selectedEntryField.Asthma || self.selectedEntryField.Thyroid || self.selectedEntryField.Medication || self.selectedEntryField.DietAndAppetite || self.selectedEntryField.Habits || self.selectedEntryField.BreastFeeding {
            self.showAdditionalFields = true
        } else {
            self.showAdditionalFields = false
        }
    }
}
