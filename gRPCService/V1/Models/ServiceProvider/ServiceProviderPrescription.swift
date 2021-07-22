//
//  ServiceProviderPrescription.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 17/03/21.
//

import Foundation
import SwiftUI

struct ServiceProviderPrescription : Codable {
    var prescriptionID:String
    var serviceRequestID:String
    var customerID:String
    var createdDateTime:Int64
    var medicineList:[ServiceProviderMedicine]
    var fileInfo:ServiceProviderFileInfo
    var uploadedPrescriptionDocuments:[ServiceProviderFileInfo]
}
