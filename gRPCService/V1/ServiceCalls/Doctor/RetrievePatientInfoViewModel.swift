//
//  RetrievePatientInfoViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 24/01/21.
//

import Foundation
import SwiftUI

class RetrievePatientInfoViewModel: RetrievePatientInfoProtocol {
    
    var appointmentObjMapper:ServiceProviderAppointmentObjectMapper
    var customerObjMapper:ServiceProviderCustomerProfileObjectMapper
    var reportObjMapper:ServiceProviderReportMapper
    
    init(
        appointmentObjMapper:ServiceProviderAppointmentObjectMapper = ServiceProviderAppointmentObjectMapper(),
        customerObjMapper:ServiceProviderCustomerProfileObjectMapper = ServiceProviderCustomerProfileObjectMapper(),
        reportObjMapper:ServiceProviderReportMapper = ServiceProviderReportMapper()) {
        self.appointmentObjMapper = appointmentObjMapper
        self.customerObjMapper = customerObjMapper
        self.reportObjMapper = reportObjMapper
    }
    
    func getPatientProfile(patientId: String, _ completion: @escaping ((ServiceProviderCustomerProfile?) -> ())) {
        
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        // Provide the connection to the generated client.
        let patientClient = Nd_V1_ServiceProviderCustomerWorkerV1Client(channel: channel)
        
        let request = Nd_V1_IdMessage.with {
            $0.id = patientId.toProto
        }
        
        let getPatientObject = patientClient.getCustomerProfile(request, callOptions: callOptions)
        
        DispatchQueue.main.async {
            do {
                let response = try getPatientObject.response.wait()
                let customer = self.customerObjMapper.grpcCustomerToLocal(customer: response)
                print("Customer Client received: \(response.customerID)")
                completion(customer)
            } catch {
                print("Customer Client failed: \(error)")
                completion(nil)
            }
        }
    }
    
    func getPatientAppointmentList(patientId: String, _ completion: @escaping (([ServiceProviderAppointment]?) -> ())) {
        
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        // Provide the connection to the generated client.
        let appointmentsClient = Nd_V1_ServiceProviderAppointmentWorkerV1Client(channel: channel)
        
        let request = Nd_V1_IdMessage.with {
            $0.id = patientId.toProto
        }
        
        let getPatientAppointments = appointmentsClient.getCustomerAppointments(request, callOptions: callOptions)
        
        DispatchQueue.main.async {
            do {
                let response = try getPatientAppointments.response.wait()
                let appointmentList = self.appointmentObjMapper.grpcAppointmentToLocal(appointment: response.appointments)
                print("Patient Appointments received")
                completion(appointmentList)
            } catch {
                print("Patient Appointments failed: \(error)")
                completion(nil)
            }
        }
    }
    
    func getUploadedReportList(customerId:String, _ completion: @escaping (([ServiceProviderReport]?) -> ())) {
        
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        // Provide the connection to the generated client.
        let reportsClient = Nd_V1_ServiceProviderReportWorkerV1Client(channel: channel)
        
        let request = Nd_V1_IdMessage.with {
            $0.id = customerId.toProto
        }
        
        let getPatientReports = reportsClient.getCustomerReports(request,callOptions: callOptions)
        
        DispatchQueue.main.async {
            do {
                let response = try getPatientReports.response.wait()
                let reportList = self.reportObjMapper.grpcReportToLocal(report: response.reports)
                print("Patient Reports received")
                completion(reportList)
            } catch {
                print("Patient Reports failed: \(error)")
                completion(nil)
            }
        }
    }
    
    func getReportImage(reportId: String, _ completion: @escaping (UIImage?) -> ()) {
        
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        // Provide the connection to the generated client.
        let reportImageClient = Nd_V1_ServiceProviderReportWorkerV1Client(channel: channel)
        
        let request = Nd_V1_IdMessage.with {
            $0.id = reportId.toProto
        }
        
        let getPatientReports = reportImageClient.downloadReportMedia(request,callOptions: callOptions)
        
        DispatchQueue.main.async {
            do {
                let response = try getPatientReports.response.wait()
                print("Patient Reports received \(response.mediaFile)")
                completion(Helpers.convertB64ToUIImage(b64Data: response.mediaFile.toString))
            } catch {
                print("Patient Reports failed: \(error)")
                completion(nil)
            }
        }
    }
}
