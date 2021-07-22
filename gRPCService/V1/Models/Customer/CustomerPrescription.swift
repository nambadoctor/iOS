//
//  CustomerPrescription.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/26/21.
//

import Foundation

struct CustomerPrescription {
    var prescriptionID:String
    var serviceRequestID:String
    var customerID:String
    var createdDateTime:Int64
    var medicineList:[CustomerMedicine]
    var fileInfo:CustomerFileInfo
    var uploadedPrescriptionDocuments:[CustomerFileInfo]
}
