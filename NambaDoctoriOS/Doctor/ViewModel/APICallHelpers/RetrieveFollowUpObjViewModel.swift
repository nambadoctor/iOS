//
//  RetrieveFollowUpObjViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 23/01/21.
//

import Foundation

class RetrieveFollowUpObjViewModel: RetrieveFollowUpFeeObjProtocol {
    //THIS READ IS CURRENTLY NOT WORKING. WILL WORK ONCE CHANGE TO MONGO DB IS MADE
    func getNextFee(patientId: String, _ completion: @escaping ((PatientFollowUpObj?) -> ())) {
        ApiGetCall.get(extensionURL: "doctor/appointment/nextfee/\(patientId)") { (data) in
            do {
                let nextFeeObj = try JSONDecoder().decode(PatientFollowUpObj.self, from: data)
                completion(nextFeeObj)
            } catch {
                print(error)
                completion(nil)
            }
        }
    }
}
