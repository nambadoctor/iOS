//
//  ReportGetSetServiceCall.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 18/03/21.
//

import Foundation
import SwiftUI

protocol ServiceProviderReportServiceProtocol {
    func getUploadedReportList(customerId:String, serviceRequestId:String, appointmentId:String, _ completion: @escaping (([ServiceProviderReport]?) -> ()))
    
    func getReportImage(reportId: String, _ completion: @escaping (String?) -> ())
}

class ServiceProviderReportService : ServiceProviderReportServiceProtocol {
    var reportObjMapper:ServiceProviderReportMapper
    
    init(reportObjMapper:ServiceProviderReportMapper = ServiceProviderReportMapper()) {
        self.reportObjMapper = reportObjMapper
    }
    
    func getUploadedReportList(customerId:String, serviceRequestId:String, appointmentId:String, _ completion: @escaping (([ServiceProviderReport]?) -> ())) {
        
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()

        // Provide the connection to the generated client.
        let reportsClient = Nd_V1_ServiceProviderReportWorkerV1Client(channel: channel)
        
        let request = Nd_V1_ServiceProviderServiceRequestRequestMessage.with {
            $0.appointmentID = appointmentId.toProto
            $0.serviceRequestID = serviceRequestId.toProto
            $0.customerID = customerId.toProto
        }
                
        let getPatientReports = reportsClient.getAppointmentReports(request, callOptions: callOptions)
        
        DispatchQueue.global().async {
            do {
                let response = try getPatientReports.response.wait()
                let reportList = self.reportObjMapper.grpcReportToLocal(report: response.reports)
                print("Patient Reports received \(reportList.count)")
                DispatchQueue.main.async {
                    if reportList.count == 0 {
                        completion(nil)
                    } else {
                        completion(reportList)
                    }
                }
            } catch {
                print("Patient Reports failed: \(error)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
    
    func getReportImage(reportId: String, _ completion: @escaping (String?) -> ()) {
        
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()
        
        // Provide the connection to the generated client.
        let reportImageClient = Nd_V1_ServiceProviderReportWorkerV1Client(channel: channel)
        
        let request = Nd_V1_IdMessage.with {
            $0.id = reportId.toProto
        }
        
        let getPatientReports = reportImageClient.downloadReportMedia(request,callOptions: callOptions)
        
        DispatchQueue.global().async {
            do {
                let response = try getPatientReports.response.wait()
                print("Patient Reports received \(response.message)")
                DispatchQueue.main.async {
                    completion(response.message.toString)
                }
            } catch {
                print("Patient Reports failed: \(error)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
}
