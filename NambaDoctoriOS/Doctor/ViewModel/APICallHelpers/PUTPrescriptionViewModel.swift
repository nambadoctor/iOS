//
//  PutPrescriptionViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 24/01/21.
//

import Foundation

class PutPrescriptionViewModel: PutPrescriptionViewModelProtocol {
    func writePrescriptionToDB(prescriptionViewModel:PrescriptionViewModel, _ completion : @escaping ((_ successfull:Bool)->())) {
        
        let prescription = prescriptionViewModel.prescription!
        
        let parameters: [String: Any] = [
            "additionalNotes": prescription.additionalNotes,
            "appointmentId": prescriptionViewModel.appointment.id,
            "clinicalSummary": prescription.clinicalSummary,
            "diagnosis": prescription.diagnosis,
            "diagnosisType": prescription.diagnosisType,
            "doctorId": prescriptionViewModel.loggedInDoctor.id,
            "medicine": medicineArrayGen(medicineArr: prescription.medicine ?? [Medicine]()),
            "planInfo": prescription.planInfo,
            "history" : prescription.history,
            "referals": ""
        ]
        
        ApiPutCall.put(parameters: parameters, extensionURL: "doctor/appointment/prescription") { (success, data) in
            print("PRESCRIPTION \(success)")
            completion(success)
        }
    }
    
    func medicineArrayGen (medicineArr:[Medicine]) -> [Any] {
        var jsonReturnArray:[Any] = [Any]()
        for medicine in medicineArr {
            var medObj : [String : Any] = [String : Any]()
            medObj["dosage"] = medicine.dosage
            medObj["medicineName"] = medicine.medicineName
            medObj["numOfDays"] = Int(medicine.numOfDays)
            medObj["splInstructions"] = medicine.splInstructions
            medObj["timings"] = medicine.timings
            medObj["routeOfAdmission"] = medicine.routeOfAdmission
            medObj["intake"] = medicine.intake
            jsonReturnArray.append(medObj)
        }

        func json(from object:Any) -> String? {
            guard let data = try? JSONSerialization.data(withJSONObject: jsonReturnArray, options: []) else {
                return nil
            }
            return String(data: data, encoding: String.Encoding.utf8)
        }

        return jsonReturnArray
    }

}
