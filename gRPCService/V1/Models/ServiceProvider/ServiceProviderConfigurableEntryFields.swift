//
//  ServiceProviderConfigurableEntryFields.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 8/20/21.
//

import Foundation

struct ServiceProviderConfigurableEntryFieldsObject {
    var organisationId:String
    var serviceProviderId:String
    var configurationName:String
    var entryFields:ServiceProviderConfigurableEntryFields
}

struct ServiceProviderConfigurableEntryFields {
    var Examination:Bool
    var Diagnosis:Bool
    var Investigations:Bool
    var Weight:Bool
    var Prescriptions:Bool
    var Advice:Bool
    var BloodPressure:Bool
    var BloodSugar:Bool
    var Height:Bool
    var MenstrualHistory:Bool
    var ObstetricHistory:Bool
    var IsSmokerOrAlcoholic:Bool
    var Menarche:Bool
    var Periods:Bool
    var AgeAtFirstChildBirth:Bool
    var LMP:Bool
    var NoOfChildren:Bool
    var BreastFeeding:Bool
    var FamilyHistoryOfCancer:Bool
    var OtherCancers:Bool
    var Diabetes:Bool
    var Hypertension:Bool
    var Asthma:Bool
    var Thyroid:Bool
    var Medication:Bool
    var DietAndAppetite:Bool
    var Habits:Bool
    var BreastExamination:Bool
}
