//
//  MedicineObjectMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 15/02/21.
//

import Foundation

class MedicineObjectMapper {
    func grpcToLocalMedicineObject(medicine:Nambadoctor_V1_MedicineObject) -> Medicine {
        let medObj = Medicine(medicineName: medicine.medicineName,
                              dosage: medicine.dosage,
                              routeOfAdministration: medicine.routeOfAdministration,
                              intake: medicine.intake,
                              duration: medicine.duration,
                              timings: medicine.timings,
                              specialInstructions: medicine.specialInstructions)
        return medObj
    }
    
    func localMedicineToGrpcObject(medicine:Medicine) -> Nambadoctor_V1_MedicineObject {
        let medObj = Nambadoctor_V1_MedicineObject.with {
            $0.medicineName = medicine.medicineName
            $0.dosage = medicine.dosage
            $0.routeOfAdministration = medicine.routeOfAdministration
            $0.intake = medicine.intake
            $0.duration = medicine.duration
            $0.timings = medicine.timings
            $0.specialInstructions = medicine.specialInstructions
        }
        
        return medObj
    }
    
    func grpcMedicineListToLocalList(medicines:[Nambadoctor_V1_MedicineObject]) -> [Medicine] {
        var medList:[Medicine] = [Medicine]()
        
        for med in medicines {
            medList.append(grpcToLocalMedicineObject(medicine: med))
        }
        
        return medList
    }
    
    func localMedicineListToGrpcList(medicines:[Medicine]) -> [Nambadoctor_V1_MedicineObject] {
        var medList:[Nambadoctor_V1_MedicineObject] = [Nambadoctor_V1_MedicineObject]()
        
        for med in medicines {
            medList.append(localMedicineToGrpcObject(medicine: med))
        }
        
        return medList
    }
}
