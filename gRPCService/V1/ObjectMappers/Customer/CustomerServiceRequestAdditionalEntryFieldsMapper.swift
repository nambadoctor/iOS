//
//  CustomerServiceRequestAdditionalEntryFieldsMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 8/24/21.
//

import Foundation

class CustomerServiceRequestAdditionalEntryFieldsMapper {
    static func localToGrpc (additionalInfo:CustomerServiceRequestAdditionalEntryFields) -> Nd_V1_CustomerServiceRequestAdditionalEntryFields {
        return Nd_V1_CustomerServiceRequestAdditionalEntryFields.with {
            $0.menarche = additionalInfo.Menarche.toProto
            $0.periods = additionalInfo.Periods.toProto
            $0.ageAtFirstChildBirth = additionalInfo.AgeAtFirstChildBirth.toProto
            $0.lmp = additionalInfo.LMP.toProto
            $0.noOfChildren = additionalInfo.NoOfChildren.toProto
            $0.breastFeeding = additionalInfo.BreastFeeding.toProto
            $0.familyHistoryOfCancer = additionalInfo.FamilyHistoryOfCancer.toProto
            $0.otherCancers = additionalInfo.OtherCancers.toProto
            $0.diabetes = additionalInfo.Diabetes.toProto
            $0.hypertension = additionalInfo.Hypertension.toProto
            $0.asthma = additionalInfo.Asthma.toProto
            $0.thyroid = additionalInfo.Thyroid.toProto
            $0.medication = additionalInfo.Medication.toProto
            $0.dietAndAppetite = additionalInfo.DietAndAppetite.toProto
            $0.habits = additionalInfo.Habits.toProto
            $0.breastExamination = additionalInfo.BreastExamination.toProto
        }
    }
    
    static func grpcToLocal (additionalInfo:Nd_V1_CustomerServiceRequestAdditionalEntryFields) -> CustomerServiceRequestAdditionalEntryFields {
        return CustomerServiceRequestAdditionalEntryFields(Menarche: additionalInfo.menarche.toString,
                                                                  Periods: additionalInfo.periods.toString,
                                                                  AgeAtFirstChildBirth: additionalInfo.ageAtFirstChildBirth.toString,
                                                                  LMP: additionalInfo.lmp.toString,
                                                                  NoOfChildren: additionalInfo.noOfChildren.toString,
                                                                  BreastFeeding: additionalInfo.breastFeeding.toString,
                                                                  FamilyHistoryOfCancer: additionalInfo.familyHistoryOfCancer.toString,
                                                                  OtherCancers: additionalInfo.otherCancers.toString,
                                                                  Diabetes: additionalInfo.diabetes.toString,
                                                                  Hypertension: additionalInfo.hypertension.toString,
                                                                  Asthma: additionalInfo.asthma.toString,
                                                                  Thyroid: additionalInfo.thyroid.toString,
                                                                  Medication: additionalInfo.medication.toString,
                                                                  DietAndAppetite: additionalInfo.dietAndAppetite.toString,
                                                                  Habits: additionalInfo.habits.toString,
                                                                  BreastExamination: additionalInfo.breastExamination.toString)
    }
}
