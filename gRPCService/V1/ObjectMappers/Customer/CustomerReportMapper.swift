//
//  CustomerReportMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/26/21.
//

import Foundation

class CustomerReportMapper {
    func grpcReportToLocal(report:Nd_V1_CustomerReportMessage) -> CustomerReport {
        return CustomerReport(
            reportID: report.reportID.toString,
            fileName: report.fileName.toString,
            name: report.name.toString,
            fileType: report.fileType.toString)
    }
    
    func grpcReportToLocal(report:[Nd_V1_CustomerReportMessage]) -> [CustomerReport] {
        var reportList:[CustomerReport] = [CustomerReport]()
        
        for rep in report {
            reportList.append(grpcReportToLocal(report: rep))
        }
        
        return reportList
    }

    func localReportToGrpc(report:CustomerReport) -> Nd_V1_CustomerReportMessage {
        return Nd_V1_CustomerReportMessage.with {
            $0.reportID = report.reportID.toProto
            $0.fileName = report.fileName.toProto
            $0.name = report.name.toProto
            $0.fileType = report.fileType.toProto
        }
    }

}
