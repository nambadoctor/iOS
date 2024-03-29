//
//  ServiceProviderReportMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 17/03/21.
//

import Foundation

class ServiceProviderReportMapper {
    func grpcReportToLocal(report:Nd_V1_ServiceProviderReportMessage) -> ServiceProviderReport {
        return ServiceProviderReport(
            reportID: report.reportID.toString,
            fileName: report.fileName.toString,
            name: report.name.toString,
            fileType: report.fileType.toString)
    }
    
    func grpcReportToLocal(report:[Nd_V1_ServiceProviderReportMessage]) -> [ServiceProviderReport] {
        var reportList:[ServiceProviderReport] = [ServiceProviderReport]()
        
        for rep in report {
            reportList.append(grpcReportToLocal(report: rep))
        }
        
        return reportList
    }

    func localReportToGrpc(report:ServiceProviderReport) -> Nd_V1_ServiceProviderReportMessage {
        return Nd_V1_ServiceProviderReportMessage.with {
            $0.reportID = report.reportID.toProto
            $0.fileName = report.fileName.toProto
            $0.name = report.name.toProto
            $0.fileType = report.fileType.toProto
        }
    }
}
