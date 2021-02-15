//
//  RetrievePatientInfoViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 24/01/21.
//

import Foundation
import SwiftUI

class RetrievePatientInfoViewModel: RetrievePatientInfoProtocol {
    
    var appointmentObjMapper:AppointmentObjMapper
    
    init(appointmentObjMapper:AppointmentObjMapper = AppointmentObjMapper()) {
        self.appointmentObjMapper = appointmentObjMapper
    }

    func getPatientProfile(patientId: String, _ completion: @escaping ((Nambadoctor_V1_PatientObject?) -> ())) {
                
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        // Provide the connection to the generated client.
        let patientClient = Nambadoctor_V1_PatientWorkerV1Client(channel: channel)

        let request = Nambadoctor_V1_PatientRequest.with {
            $0.patientID = patientId
        }

        let getPatientObject = patientClient.getPatientObject(request, callOptions: callOptions)

        do {
            let response = try getPatientObject.response.wait()
            print("Patient Client received: \(response.patientID)")
            completion(response)
        } catch {
            print("Patient Client failed: \(error)")
            completion(nil)
        }
    }
    
    func getPatientAppointmentList(patientId: String, _ completion: @escaping (([Appointment]?) -> ())) {
                
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        // Provide the connection to the generated client.
        let appointmentsClient = Nambadoctor_V1_AppointmentWorkerV1Client(channel: channel)

        let request = Nambadoctor_V1_AppointmentPatientRequest.with {
            $0.patientID = patientId
        }

        let getPatientAppointments = appointmentsClient.getAllPatientAppointments(request, callOptions: callOptions)

        do {
            let response = try getPatientAppointments.response.wait()
            let appointmentList = appointmentObjMapper.grpcAppointmentListToLocalAppointmentList(appointmentList: response.appointmentResponse)
            print("Patient Appointments received")
            completion(appointmentList)
        } catch {
            print("Patient Appointments failed: \(error)")
            completion(nil)
        }
    }

    func getUploadedReportList(appointment: Appointment, _ completion: @escaping (([Nambadoctor_V1_ReportDownloadObject]?) -> ())) {
                
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        // Provide the connection to the generated client.
        let reportsClient = Nambadoctor_V1_ReportWorkerV1Client(channel: channel)

        let request = Nambadoctor_V1_ReportPatRequest.with {
            $0.patientID = appointment.requestedBy
        }

        let getPatientReports = reportsClient.getAllPatientReports(request, callOptions:callOptions)

        do {
            let response = try getPatientReports.response.wait()
            print("Patient Reports received")
            completion(response.reports)
        } catch {
            print("Patient Reports failed: \(error)")
            completion(nil)
        }
    }
    
    func getReportImage(reportId: String, _ completion: @escaping (UIImage?) -> ()) {
                
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        // Provide the connection to the generated client.
        let reportImageClient = Nambadoctor_V1_ReportWorkerV1Client(channel: channel)

        let request = Nambadoctor_V1_MediaName.with {
            $0.name = reportId
        }

        let getPatientReports = reportImageClient.downloadReportMedia(request, callOptions:callOptions)

        do {
            let response = try getPatientReports.response.wait()
            print("Patient Reports received \(response.mediaFile)")
            completion(Helpers.convertB64ToUIImage(b64Data: response.mediaFile.base64EncodedString()))
        } catch {
            print("Patient Reports failed: \(error)")
            completion(nil)
        }
    }
}
