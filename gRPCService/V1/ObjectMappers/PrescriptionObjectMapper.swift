//
//  PrescriptionObjectMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 15/02/21.
//

import Foundation

class PrescriptionObjectMapper {
    
    var medicineObjMapper:MedicineObjectMapper
    
    init(medicineObjMapper:MedicineObjectMapper = MedicineObjectMapper()) {
        self.medicineObjMapper = medicineObjMapper
    }
    
    func grpcToLocalPrescriptionObject(prescription:Nambadoctor_V1_PrescriptionObject) -> Prescription {
        
        let medList = medicineObjMapper.grpcMedicineListToLocalList(medicines: prescription.medicines)
        
        let prescriptionObj = Prescription(id: prescription.id,
                                           appointmentID: prescription.appointmentID,
                                           history: prescription.history,
                                           examination: prescription.examination,
                                           diagnosis: prescription.diagnosis,
                                           diagnosisType: prescription.diagnosisType,
                                           investigations: prescription.investigations.investigation,
                                           advice: prescription.advice,
                                           doctorID: prescription.doctorID,
                                           patientID: prescription.patientID,
                                           createdDateTime: prescription.createdDateTime,
                                           medicines: medList)
        
        return prescriptionObj
    }
    
    func localPrescriptionToGrpcObject(prescription:Prescription) -> Nambadoctor_V1_PrescriptionObject {
        
        let medList = medicineObjMapper.localMedicineListToGrpcList(medicines: prescription.medicines)
        
        let prescriptionObj = Nambadoctor_V1_PrescriptionObject.with {
            $0.id = ""
            $0.appointmentID = prescription.appointmentID
            $0.history = prescription.history
            $0.examination = prescription.examination
            $0.diagnosis = prescription.diagnosis
            $0.diagnosisType = prescription.diagnosisType
            $0.investigations.investigation = prescription.investigations
            $0.advice = prescription.advice
            $0.doctorID = prescription.doctorID
            $0.patientID = prescription.patientID
            $0.createdDateTime = prescription.createdDateTime
            $0.medicines = medList
        }
        
        return prescriptionObj
    }
}
