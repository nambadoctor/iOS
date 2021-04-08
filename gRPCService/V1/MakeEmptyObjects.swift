//
//  MakeEmptyObjects.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 18/03/21.
//

import Foundation

func MakeEmptyMedicine() -> ServiceProviderMedicine {
    return ServiceProviderMedicine(medicineName: "", dosage: "", routeOfAdministration: "", intake: "", duration: 0, timings: "", specialInstructions: "", medicineID: "")
}

func MakeEmptyServiceRequest(appointment:ServiceProviderAppointment) -> ServiceProviderServiceRequest {
    return ServiceProviderServiceRequest(serviceRequestID: appointment.serviceRequestID, reason: "", serviceProviderID: appointment.serviceProviderID, appointmentID: appointment.appointmentID, examination: "", diagnosis: MakeEmptyDiagnosis(), investigations: [String](), advice: "", createdDateTime: Date().millisecondsSince1970, lastModifiedDate: Date().millisecondsSince1970, customerID: appointment.customerID, allergy: MakeEmptyAllergy(), medicalHistory: MakeEmptyMedicalHistory())
}

func MakeEmptyAllergy() -> ServiceProviderCustomerAllergy {
    return ServiceProviderCustomerAllergy(AllergyId: "", AllergyName: "", AppointmentId: "", ServiceRequestId: "")
}

func MakeEmptyMedicalHistory () -> ServiceProviderCustomerMedicalHistory {
    return ServiceProviderCustomerMedicalHistory(MedicalHistoryId: "", MedicalHistoryName: "", AppointmentId: "", ServiceRequestId: "")
}

func MakeEmptyDiagnosis () -> ServiceProviderDiagnosis {
    return ServiceProviderDiagnosis(name: "", type: "")
}

func MakeEmptyPrescription(appointment:ServiceProviderAppointment) -> ServiceProviderPrescription {
    return ServiceProviderPrescription(prescriptionID: "", serviceRequestID: appointment.serviceRequestID, customerID: appointment.customerID, createdDateTime: 0, medicineList: [ServiceProviderMedicine](), fileInfo: MakeEmptyFileInfoObj())
}

func MakeEmptyFileInfoObj() -> ServiceProviderFileInfo {
    return ServiceProviderFileInfo(FileName: "", FileType: "", MediaImage: "")
}
