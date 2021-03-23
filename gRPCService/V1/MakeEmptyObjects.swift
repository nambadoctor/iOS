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

func MakeEmptyPrescription() -> ServiceProviderPrescription {
    return ServiceProviderPrescription(prescriptionID: "", serviceRequestID: "", customerID: "", createdDateTime: 0, medicineList: [ServiceProviderMedicine](), fileInfo: MakeEmptyFileInfoObj())
}

func MakeEmptyFileInfoObj() -> ServiceProviderFileInfo {
    return ServiceProviderFileInfo(FileName: "", FileType: "", MediaImage: "")
}
