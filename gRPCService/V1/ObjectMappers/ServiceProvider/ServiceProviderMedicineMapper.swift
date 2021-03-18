//
//  ServiceProviderMedicineMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 17/03/21.
//

import Foundation

class ServiceProviderMedicineMapper {
    static func grpcMedicineToLocal (medicine:Nd_V1_ServiceProviderMedicineMessage) -> ServiceProviderMedicine {
        return ServiceProviderMedicine(
            medicineName: medicine.medicineName.toString,
            dosage: medicine.dosage.toString,
            routeOfAdministration: medicine.routeOfAdministration.toString,
            intake: medicine.intake.toString,
            duration: medicine.duration.toInt32,
            timings: medicine.timings.toString,
            specialInstructions: medicine.specialInstructions.toString,
            medicineID: medicine.medicineID.toString)
    }
    
    static func grpcMedicineToLocal (medicines:[Nd_V1_ServiceProviderMedicineMessage]) -> [ServiceProviderMedicine] {
        var medList:[ServiceProviderMedicine] = [ServiceProviderMedicine]()
        
        for med in medicines {
            medList.append(grpcMedicineToLocal(medicine: med))
        }
        
        return medList
    }
    
    static func localMedicineToGrpc (medicine:ServiceProviderMedicine) -> Nd_V1_ServiceProviderMedicineMessage {
        return Nd_V1_ServiceProviderMedicineMessage.with {
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
    
    static func localMedicineToGrpc (medicines:[ServiceProviderMedicine]) -> [Nd_V1_ServiceProviderMedicineMessage] {
        var medList:[Nd_V1_ServiceProviderMedicineMessage] = [Nd_V1_ServiceProviderMedicineMessage]()
        
        for med in medicines {
            medList.append(localMedicineToGrpc(medicine: med))
        }
        
        return medList
    }
}
