//
//  CustomerReportUploadMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/26/21.
//

import Foundation

class CustomerReportUploadMapper {
    func grpcReportToLocal(report:Nd_V1_CustomerReportUploadMessage) -> CustomerReportUpload {
        return CustomerReportUpload(ReportId: report.reportID.toString,
                                    ServiceRequestId: report.serviceRequestID.toString,
                                    CustomerId: report.customerID.toString,
                                    FileName: report.fileName.toString,
                                    Name: report.name.toString,
                                    FileType: report.fileType.toString,
                                    MediaFile: report.mediaFile.toString)
    }
    
    func localReportToGrpc(report:CustomerReportUpload) -> Nd_V1_CustomerReportUploadMessage {
        return Nd_V1_CustomerReportUploadMessage.with {
            $0.reportID = report.ReportId.toProto
            $0.serviceRequestID = report.ServiceRequestId.toProto
            $0.customerID = report.CustomerId.toProto
            $0.fileName = report.FileName.toProto
            $0.name = report.Name.toProto
            $0.fileType = report.FileType.toProto
            $0.mediaFile = report.MediaFile.toProtoBytes
        }
    }
}
