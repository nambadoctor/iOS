//
//  RetrievePatientInfoViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 24/01/21.
//

import Foundation
import SwiftUI

class RetrievePatientInfo: RetrievePatientInfoProtocol {
    func getPatientProfile(patientId: String, _ completion: @escaping ((Patient) -> ())) {
        ApiGetCall.get(extensionURL: "patient/profile/\(patientId)") { (data) in
            do {
                let patient = try JSONDecoder().decode(Patient.self, from: data)
                completion(patient)
            } catch {
                print(error)
            }
        }
    }
    
    func getPatientAppointmentList(patientId: String, _ completion: @escaping (([Appointment]) -> ())) {
        ApiGetCall.get(extensionURL: "patient/appointments/latest/\(patientId)") { (data) in
            do {
                let appointments = try JSONDecoder().decode([Appointment].self, from: data)
                completion(appointments)
            } catch {
                print(error)
            }
        }
    }

    func getUploadedDocumentList(appointmentId: String, _ completion: @escaping (([UploadedDocument]) -> ())) {
        ApiGetCall.get(extensionURL: "documnet/appointment/\(appointmentId)") { (data) in
            do {
                let uploadedDocList = try JSONDecoder().decode([UploadedDocument].self, from: data)
                completion(uploadedDocList)
            } catch {
                print(error)
            }
        }
    }
    
    func getDocImage(docId: String, _ completion: @escaping ((UIImage?) -> ())) {
        ApiGetCall.get(extensionURL: "documnet/image/\(docId)") { (data) in
            do {
                let imageDict = try JSONDecoder().decode([String:String].self, from: data)
                let imageString = imageDict["base64Image"]!
                completion(Helpers.convertB64ToUIImage(b64Data: imageString))
            } catch {
                print(error)
            }
        }
    }
}
