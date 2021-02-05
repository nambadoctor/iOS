//
//  RetrievePatientInfoViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 24/01/21.
//

import Foundation
import SwiftUI

class RetrievePatientInfo: RetrievePatientInfoProtocol {
    func getPatientProfile(patientId: String, _ completion: @escaping ((Nambadoctor_V1_PatientObject) -> ())) {
        
        let channel = ChannelManager.sharedChannelManager.getChannel()
        
        // Provide the connection to the generated client.
        let patientClient = Nambadoctor_V1_PatientWorkerV1Client(channel: channel)

        let request = Nambadoctor_V1_PatientRequest.with {
            $0.patientID = patientId
        }

        let getPatientObject = patientClient.getPatientObject(request)

        do {
            let response = try getPatientObject.response.wait()
            print("PatientClient received: \(response.patientID)")
            completion(response)
        } catch {
            print("PatientClient failed: \(error)")
        }
    }
    
    func getPatientAppointmentList(patientId: String, _ completion: @escaping (([Nambadoctor_V1_AppointmentObject]) -> ())) {
        
        let channel = ChannelManager.sharedChannelManager.getChannel()
        
        // Provide the connection to the generated client.
        let appointmentsClient = Nambadoctor_V1_AppointmentWorkerV1Client(channel: channel)

        let request = Nambadoctor_V1_AppointmentPatientRequest.with {
            $0.patientID = patientId
        }

        let getPatientAppointments = appointmentsClient.getAllPatientAppointments(request)

        do {
            let response = try getPatientAppointments.response.wait()
            print("PatientClient received")
            completion(response.appointmentResponse)
        } catch {
            print("PatientClient failed: \(error)")
        }
    }

    func getUploadedDocumentList(appointmentId: String, _ completion: @escaping (([Nambadoctor_V1_ReportDownloadObject]) -> ())) {
//        ApiGetCall.get(extensionURL: "documnet/appointment/\(appointmentId)") { (data) in
//            do {
//                let uploadedDocList = try JSONDecoder().decode([UploadedDocument].self, from: data)
//                completion(uploadedDocList)
//            } catch {
//                print(error)
//            }
//        }
    }
    
    func getDocImage(docId: String, _ completion: @escaping ((UIImage?) -> ())) {
//        ApiGetCall.get(extensionURL: "documnet/image/\(docId)") { (data) in
//            do {
//                let imageDict = try JSONDecoder().decode([String:String].self, from: data)
//                let imageString = imageDict["base64Image"]!
//                completion(Helpers.convertB64ToUIImage(b64Data: imageString))
//            } catch {
//                print(error)
//            }
//        }
    }
}
