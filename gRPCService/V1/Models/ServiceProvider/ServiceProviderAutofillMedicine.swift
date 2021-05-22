//
//  ServiceProviderAutofillMedicine.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/21/21.
//

import Foundation

struct ServiceProviderAutofillMedicine {
    var AutofillMedicineId:String
    var MedicineGenericName:String
    var MedicineBrandName:String
    var RouteOfAdmission:String
    var Intake:String
    var Frequency:String
    var Dosage:ServiceProviderDosage
    var Duration:ServiceProviderDuration
}
