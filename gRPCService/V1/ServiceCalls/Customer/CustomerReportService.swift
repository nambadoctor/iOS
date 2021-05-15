//
//  CustomerReportService.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/27/21.
//

import Foundation

protocol CustomerReportServiceProtocol {
    func getAppointmentUploadedReportList(customerId:String, serviceRequestId:String, appointmentId:String, _ completion: @escaping (([CustomerReport]?) -> ()))
    func setReport(report:CustomerReportUpload, _ completion : @escaping ((_ successfull:Bool)->()))
    func getReportImage(reportId: String, _ completion: @escaping (String?) -> ())
}

class CustomerReportService : CustomerReportServiceProtocol {
    var reportObjMapper:CustomerReportMapper
    var reportUploadObjMapper:CustomerReportUploadMapper
    
    init(reportObjMapper:CustomerReportMapper = CustomerReportMapper(),
         reportUploadObjMapper:CustomerReportUploadMapper = CustomerReportUploadMapper()) {
        self.reportObjMapper = reportObjMapper
        self.reportUploadObjMapper = reportUploadObjMapper
    }
    
    func getAppointmentUploadedReportList(customerId:String, serviceRequestId:String, appointmentId:String, _ completion: @escaping (([CustomerReport]?) -> ())) {
        
        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()

        // Provide the connection to the generated client.
        let reportsClient = Nd_V1_CustomerReportWorkerV1Client(channel: channel)
        
        let request = Nd_V1_CustomerServiceRequestRequestMessage.with {
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

    func setReport(report:CustomerReportUpload, _ completion : @escaping ((_ successfull:Bool)->())) {

        let channel = ChannelManager.sharedChannelManager.getChannel()
        let callOptions = ChannelManager.sharedChannelManager.getCallOptions()

        let reportClient = Nd_V1_CustomerReportWorkerV1Client(channel: channel)

        let request = reportUploadObjMapper.localReportToGrpc(report: report)

        let setReport = reportClient.setReport(request, callOptions: callOptions)

        DispatchQueue.global().async {
            do {
                let response = try setReport.response.wait()
                print("Report Write Client Successfull: \(response.id)")
                DispatchQueue.main.async {
                    completion(true)
                }
            } catch {
                print("Report Write Client Failed: \(error)")
                DispatchQueue.main.async {
                    completion(false)
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
                print("Patient Report Image received \(response.message)")
                DispatchQueue.main.async {
                    completion(response.message.toString)
                }
            } catch {
                print("Patient Report Image failed: \(error)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
}
