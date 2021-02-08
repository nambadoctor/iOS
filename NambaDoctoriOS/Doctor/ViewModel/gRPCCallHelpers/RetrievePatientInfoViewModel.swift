//
//  RetrievePatientInfoViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 24/01/21.
//

import Foundation
import SwiftUI

class RetrievePatientInfoViewModel: RetrievePatientInfoProtocol {
    
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

    func getUploadedReportList(appointment: Nambadoctor_V1_AppointmentObject, _ completion: @escaping (([Nambadoctor_V1_ReportDownloadObject]) -> ())) {
        let channel = ChannelManager.sharedChannelManager.getChannel()
        
        // Provide the connection to the generated client.
        let reportsClient = Nambadoctor_V1_ReportWorkerV1Client(channel: channel)

        let request = Nambadoctor_V1_ReportPatRequest.with {
            $0.patientID = appointment.requestedBy
        }

        let getPatientReports = reportsClient.getAllPatientReports(request)

        do {
            let response = try getPatientReports.response.wait()
            print("Patient Reports received")
            completion(response.reports)
        } catch {
            print("Patient Reports failed: \(error)")
        }
    }
    
    func getReportImage(reportId: String, _ completion: @escaping ((UIImage?) -> ())) {
        let channel = ChannelManager.sharedChannelManager.getChannel()
        
        // Provide the connection to the generated client.
        let reportImageClient = Nambadoctor_V1_ReportWorkerV1Client(channel: channel)

        let request = Nambadoctor_V1_MediaName.with {
            $0.name = reportId
        }

        let getPatientReports = reportImageClient.downloadReportMedia(request)

        do {
            let response = try getPatientReports.response.wait()
            print("Patient Reports received \(response.mediaFile)")
            completion(UIImage(data: response.mediaFile, scale: 1.0))
        } catch {
            print("Patient Reports failed: \(error)")
        }
    }
}
