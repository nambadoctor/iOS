//
//  ServiceProviderAutofillMedicineMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/20/21.
//

import Foundation

class ServiceProviderAutofillMedicineMapper {
    static func LocalToGrpc (medicine:Nd_V1_ServiceProviderAutofillMedicineMessage) -> ServiceProviderAutofillMedicine {
        return ServiceProviderAutofillMedicine(AutofillMedicineId: medicine.autofillMedicineID.toString,
                                               MedicineGenericName: medicine.medicineGenericName.toString,
                                               MedicineBrandName: medicine.medicineBrandName.toString,
                                               RouteOfAdmission: medicine.routeOfAdmission.toString,
                                               Intake: medicine.intake.toString,
                                               Frequency: medicine.frequency.toString,
                                               Dosage: ServiceProviderDosageMapper.GrpcToLocal(dosage: medicine.dosage),
                                               Duration: ServiceProviderDurationMapper.GrpcToLocal(duration: medicine.duration))
    }
    
    static func LocalToGrpc (medicines:[Nd_V1_ServiceProviderAutofillMedicineMessage]) -> [ServiceProviderAutofillMedicine] {
        var localMedicines:[ServiceProviderAutofillMedicine] = [ServiceProviderAutofillMedicine]()
        
        for med in medicines {
            localMedicines.append(LocalToGrpc(medicine: med))
        }
        
        return localMedicines
    }
}
