//
//  CustomerMedicineMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/26/21.
//

import Foundation

class CustomerMedicineMapper {
    static func grpcMedicineToLocal (medicine:Nd_V1_CustomerMedicineMessage) -> CustomerMedicine {
        return CustomerMedicine(
            medicineName: medicine.medicineName.toString,
            dosage: medicine.dosage.toString,
            routeOfAdministration: medicine.routeOfAdministration.toString,
            intake: medicine.intake.toString,
            duration: medicine.duration.toInt32,
            timings: medicine.timings.toString,
            specialInstructions: medicine.specialInstructions.toString,
            medicineID: medicine.medicineID.toString)
    }
    
    static func grpcMedicineToLocal (medicines:[Nd_V1_CustomerMedicineMessage]) -> [CustomerMedicine] {
        var medList:[CustomerMedicine] = [CustomerMedicine]()
        
        for med in medicines {
            medList.append(grpcMedicineToLocal(medicine: med))
        }
        
        return medList
    }
    
    static func localMedicineToGrpc (medicine:CustomerMedicine) -> Nd_V1_CustomerMedicineMessage {
        return Nd_V1_CustomerMedicineMessage.with {
            $0.medicineName = medicine.medicineName.toProto
            $0.dosage = medicine.dosage.toProto
            $0.routeOfAdministration = medicine.routeOfAdministration.toProto
            $0.intake = medicine.intake.toProto
            $0.duration = medicine.duration.toProto
            $0.timings = medicine.timings.toProto
            $0.specialInstructions = medicine.specialInstructions.toProto
            $0.medicineID = medicine.medicineID.toProto
        }
    }
    
    static func localMedicineToGrpc (medicines:[CustomerMedicine]) -> [Nd_V1_CustomerMedicineMessage] {
        var medList:[Nd_V1_CustomerMedicineMessage] = [Nd_V1_CustomerMedicineMessage]()

        for med in medicines {
            medList.append(localMedicineToGrpc(medicine: med))
        }
        
        return medList
    }

}
