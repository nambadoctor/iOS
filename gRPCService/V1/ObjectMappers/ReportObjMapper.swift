//
//  ReportObjMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 15/02/21.
//

import Foundation

class ReportObjMapper {
    func grpcToLocalReportObject(report:Nambadoctor_V1_ReportDownloadObject) -> Report {
        let reportObj = Report(id: report.id,
                               name: report.name,
                               appointmentID: report.appointmentID,
                               patientID: report.patientID,
                               createdDateTime: report.createdDateTime,
                               fileType: report.fileType)
        
        return reportObj
    }
    
    func localReportToGrpcObject(report:Report) -> Nambadoctor_V1_ReportDownloadObject {
        let reportObj = Nambadoctor_V1_ReportDownloadObject.with {
            $0.id = report.id
            $0.name = report.name
            $0.appointmentID = report.appointmentID
            $0.patientID = report.patientID
            $0.createdDateTime = report.createdDateTime
            $0.fileType = report.fileType
        }
        
        return reportObj
    }
    
    func localReportToGrpcList(reportList:[Report]) -> [Nambadoctor_V1_ReportDownloadObject] {
        var localReportList = [Nambadoctor_V1_ReportDownloadObject]()
        
        for report in reportList {
            localReportList.append(localReportToGrpcObject(report: report))
        }
        
        return localReportList
    }
    
    func grpcReportToLocalList(reportList:[Nambadoctor_V1_ReportDownloadObject]) -> [Report] {
        var localReportList = [Report]()
        
        for report in reportList {
            localReportList.append(grpcToLocalReportObject(report: report))
        }
        
        return localReportList
    }

}
