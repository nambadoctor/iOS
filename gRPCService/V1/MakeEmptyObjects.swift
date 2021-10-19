//
//  MakeEmptyObjects.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 18/03/21.
//

import Foundation

func MakeEmptyMedicine() -> ServiceProviderMedicine {
    return ServiceProviderMedicine(medicineName: "", intakeDosage: MakeEmptyDosage(), routeOfAdministration: "", intake: "", _duration: MakeEmptyDuration(), timings: "", specialInstructions: "", medicineID: "", notes: "")
}

func MakeEmptyDosage() -> ServiceProviderIntakeDosage {
    return ServiceProviderIntakeDosage(Name: "", Unit: "")
}

func MakeEmptyDuration() -> ServiceProviderDuration {
    return ServiceProviderDuration(Days: "", Unit: "Days")
}

func MakeEmptyServiceRequest(appointment:ServiceProviderAppointment) -> ServiceProviderServiceRequest {
    return ServiceProviderServiceRequest(serviceRequestID: appointment.serviceRequestID, reason: "", serviceProviderID: appointment.serviceProviderID, appointmentID: appointment.appointmentID, examination: "", diagnosis: MakeEmptyDiagnosis(), investigations: [String](), advice: "", createdDateTime: Date().millisecondsSince1970, lastModifiedDate: Date().millisecondsSince1970, customerID: appointment.customerID, allergy: MakeEmptyAllergy(), medicalHistory: MakeEmptyMedicalHistory(), childId: "", customerVitals: ServiceProviderCustomerVitals(BloodPressure: "", BloodSugar: "", Height: "", Weight: "", MenstrualHistory: "", ObstetricHistory: "", IsSmoker: false, IsAlcoholConsumer: false, Pulse: "", RespiratoryRate: "", Temperature: "", Saturation: ""), organisationId: "", additionalEntryFields: makeEmptyAdditionalEntryFields())
}

func makeEmptyAdditionalEntryFields () -> ServiceProviderServiceRequestAdditionalEntryFields {
    return ServiceProviderServiceRequestAdditionalEntryFields(Menarche: "", Periods: "", AgeAtFirstChildBirth: "", LMP: "", NoOfChildren: "", BreastFeeding: "", FamilyHistoryOfCancer: "", OtherCancers: "", Diabetes: "", Hypertension: "", Asthma: "", Thyroid: "", Medication: "", DietAndAppetite: "", Habits: "", BreastExamination: "", FamilyHistoryOfOtherDiseases: "")
}

func makeEmptyCustomerAdditionalEntryFields () -> CustomerServiceRequestAdditionalEntryFields {
    return CustomerServiceRequestAdditionalEntryFields(Menarche: "", Periods: "", AgeAtFirstChildBirth: "", LMP: "", NoOfChildren: "", BreastFeeding: "", FamilyHistoryOfCancer: "", OtherCancers: "", Diabetes: "", Hypertension: "", Asthma: "", Thyroid: "", Medication: "", DietAndAppetite: "", Habits: "", BreastExamination: "", FamilyHistoryOfOtherDiseases: "")
}


func MakeEmptyAllergy() -> ServiceProviderCustomerAllergy {
    return ServiceProviderCustomerAllergy(AllergyId: "", AllergyName: "", AppointmentId: "", ServiceRequestId: "")
}

func MakeEmptyMedicalHistory () -> ServiceProviderCustomerMedicalHistory {
    return ServiceProviderCustomerMedicalHistory(MedicalHistoryId: "", MedicalHistoryName: "", PastMedicalHistory: "", MedicationHistory: "", AppointmentId: "", ServiceRequestId: "")
}

func MakeEmptyDiagnosis () -> ServiceProviderDiagnosis {
    return ServiceProviderDiagnosis(name: "", type: "Provisional")
}

func MakeEmptyPrescription(appointment:ServiceProviderAppointment) -> ServiceProviderPrescription {
    return ServiceProviderPrescription(prescriptionID: "", serviceRequestID: appointment.serviceRequestID, customerID: appointment.customerID, createdDateTime: 0, medicineList: [ServiceProviderMedicine](), fileInfo: MakeEmptyServiceProviderFileInfoObj(), uploadedPrescriptionDocuments: [ServiceProviderFileInfo]())
}

func MakeEmptyServiceProviderFileInfoObj() -> ServiceProviderFileInfo {
    return ServiceProviderFileInfo(FileName: "", FileType: "", MediaImage: "", FileInfoId: "")
}

func MakeEmptyCustomeFileInfoObj() -> CustomerFileInfo {
    return CustomerFileInfo(FileName: "", FileType: "", MediaImage: "", FileInfoId: "")
}
