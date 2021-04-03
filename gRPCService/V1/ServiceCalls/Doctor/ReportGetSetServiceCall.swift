//
//  ReportGetSetServiceCall.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 18/03/21.
//

import Foundation
import SwiftUI

protocol ReportGetSetServiceCallProtocol {
    func getUploadedReportList(customerId:String, _ completion: @escaping (([ServiceProviderReport]?) -> ()))
    
    func getReportImage(reportId: String, _ completion: @escaping (String?) -> ())
}

class ReportGetSetServiceCall : ReportGetSetServiceCallProtocol {
    var reportObjMapper:ServiceProviderReportMapper
    
    init(reportObjMapper:ServiceProviderReportMapper = ServiceProviderReportMapper()) {
        self.reportObjMapper = reportObjMapper
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
        
        DispatchQueue.global().async {
            do {
                let response = try getPatientReports.response.wait()
                let reportList = self.reportObjMapper.grpcReportToLocal(report: response.reports)
                print("Patient Reports received")
                DispatchQueue.main.async {
                    completion(reportList)
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
