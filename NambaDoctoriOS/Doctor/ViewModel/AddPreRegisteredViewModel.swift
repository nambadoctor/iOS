//
//  AddPreRegisteredViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 25/01/21.
//

import Foundation

class AddPreRegisteredViewModel {
    func preRegisterPatient(patientObj:PreRegisteredPatient, nextFeeObj:FollowUpAppointmentViewModel, _ completion : @escaping ((_ patientId:String?)->())) {
        let parameters: [String: Any] = [
            "age": patientObj.patientAge,
            "deviceTokenId": "",
            "fullName": patientObj.patientName,
            "gender": patientObj.patientGender,
            "language": "",
            "phoneNumber": patientObj.phNumberObj.countryCode + patientObj.phNumberObj.number
        ]

        ApiPutCall.put(parameters: parameters, extensionURL: "patient/preregister") { (success, data) in
            do {
                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                        // try to read out a string array
                        if let patientId = json["id"] as? String {
                            completion(patientId)
                        }
                    }
            } catch {
                completion(nil)
                print(error)
            }
        }
    }
}
