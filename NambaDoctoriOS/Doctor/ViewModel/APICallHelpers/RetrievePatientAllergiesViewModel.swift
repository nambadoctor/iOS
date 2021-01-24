//
//  RetrievePatientAllergiesViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 23/01/21.
//

import Foundation

class RetrievePatientAllergiesViewModel: RetrievePatientAllergiesProtocol {
    func getPatientAllergies (patientId:String, _ completion: @escaping ((_ allergies:String)->())) {
        ApiGetCall.get(extensionURL: "patient/allergies/\(patientId)") { (data) in
            do {
                let allergiesDict = try JSONDecoder().decode([String:String].self, from: data)
                completion(allergiesDict["allergies"] ?? "None")
            } catch {
                print(error)
            }
        }
    }
}
