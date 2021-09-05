//
//  ServiceProviderConfigurableEntryFieldsMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 8/20/21.
//

import Foundation

class ServiceProviderConfigurableEntryFieldsObjectMapper {
    static func grpcToLocal (entryFieldsObjects: Nd_V1_ServiceProviderConfigurableEntryFieldsObjectMessageList) -> [ServiceProviderConfigurableEntryFieldsObject] {
        
        var toReturn = [ServiceProviderConfigurableEntryFieldsObject]()
        
        for entryField in entryFieldsObjects.entryFieldList {
            toReturn.append(ServiceProviderConfigurableEntryFieldsObject(organisationId: entryField.organisationID.toString, serviceProviderId: entryField.serviceProviderID.toString, entryFields: ServiceProviderConfigurableEntryFieldsMapper.grpcToLocal(entryFields: entryField.entryField)))
        }
        
        return toReturn
    }
}

class ServiceProviderConfigurableEntryFieldsMapper {
    static func localToGrpc (entryFields:ServiceProviderConfigurableEntryFields) -> Nd_V1_ServiceProviderConfigurableEntryFieldsMessage {
        return Nd_V1_ServiceProviderConfigurableEntryFieldsMessage.with {
            $0.examination = entryFields.Examination.toProto
            $0.diagnosis = entryFields.Diagnosis.toProto
            $0.investigations = entryFields.Investigations.toProto
            $0.weight = entryFields.Weight.toProto
            $0.prescriptions = entryFields.Prescriptions.toProto
            $0.advice = entryFields.Advice.toProto
            $0.bloodPressure = entryFields.BloodPressure.toProto
            $0.bloodSugar = entryFields.BloodSugar.toProto
            $0.height = entryFields.Height.toProto
            $0.menstrualHistory = entryFields.MenstrualHistory.toProto
            $0.obstetricHistory = entryFields.ObstetricHistory.toProto
            $0.isSmokerOrAlcoholic = entryFields.IsSmokerOrAlcoholic.toProto
            $0.menarche = entryFields.Menarche.toProto
            $0.periods = entryFields.Periods.toProto
            $0.ageAtFirstChildBirth = entryFields.AgeAtFirstChildBirth.toProto
            $0.lmp = entryFields.LMP.toProto
            $0.noOfChildren = entryFields.NoOfChildren.toProto
            $0.breastFeeding = entryFields.BreastFeeding.toProto
            $0.familyHistoryOfCancer = entryFields.FamilyHistoryOfCancer.toProto
            $0.lmp = entryFields.LMP.toProto
            $0.otherCancers = entryFields.OtherCancers.toProto
            $0.diabetes = entryFields.Diabetes.toProto
            $0.hypertension = entryFields.Hypertension.toProto
            $0.thyroid = entryFields.Thyroid.toProto
            $0.medication = entryFields.Medication.toProto
            $0.dietAndAppetite = entryFields.DietAndAppetite.toProto
            $0.habits = entryFields.Habits.toProto
            $0.breastExamination = entryFields.Examination.toProto
        }
    }
    
    static func grpcToLocal (entryFields:Nd_V1_ServiceProviderConfigurableEntryFieldsMessage) -> ServiceProviderConfigurableEntryFields {
        return ServiceProviderConfigurableEntryFields(Examination: entryFields.examination.toBool,
                                                      Diagnosis: entryFields.diagnosis.toBool,
                                                      Investigations: entryFields.investigations.toBool,
                                                      Weight: entryFields.weight.toBool,
                                                      Prescriptions: entryFields.prescriptions.toBool,
                                                      Advice: entryFields.advice.toBool,
                                                      BloodPressure: entryFields.bloodPressure.toBool,
                                                      BloodSugar: entryFields.bloodSugar.toBool,
                                                      Height: entryFields.height.toBool,
                                                      MenstrualHistory: entryFields.menstrualHistory.toBool,
                                                      ObstetricHistory: entryFields.obstetricHistory.toBool,
                                                      IsSmokerOrAlcoholic: entryFields.isSmokerOrAlcoholic.toBool,
                                                      Menarche: entryFields.menarche.toBool,
                                                      Periods: entryFields.periods.toBool,
                                                      AgeAtFirstChildBirth: entryFields.ageAtFirstChildBirth.toBool,
                                                      LMP: entryFields.lmp.toBool,
                                                      NoOfChildren: entryFields.noOfChildren.toBool,
                                                      BreastFeeding: entryFields.breastFeeding.toBool,
                                                      FamilyHistoryOfCancer: entryFields.familyHistoryOfCancer.toBool,
                                                      OtherCancers: entryFields.otherCancers.toBool,
                                                      Diabetes: entryFields.diabetes.toBool,
                                                      Hypertension: entryFields.hypertension.toBool,
                                                      Asthma: entryFields.asthma.toBool,
                                                      Thyroid: entryFields.thyroid.toBool,
                                                      Medication: entryFields.medication.toBool,
                                                      DietAndAppetite: entryFields.dietAndAppetite.toBool,
                                                      Habits: entryFields.habits.toBool,
                                                      BreastExamination: entryFields.breastExamination.toBool)
    }
    
    static func manyGrpcToLocal (entryFields:[Nd_V1_ServiceProviderConfigurableEntryFieldsMessage]) -> [ServiceProviderConfigurableEntryFields] {
        var entryFieldsToReturn = [ServiceProviderConfigurableEntryFields]()
        
        for entryField in entryFields {
            entryFieldsToReturn.append(grpcToLocal(entryFields: entryField))
        }
        
        return entryFieldsToReturn
    }
}
