//
//  ServiceProviderAppointmentSummaryMapper.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 6/9/21.
//

import Foundation

class ServiceProviderAppointmentSummaryMapper {
    static func GrpcToLocal (appointmentSummary:Nd_V1_ServiceProviderAppointmentSummaryMessage) -> ServiceProviderAppointmentSummary {
        return ServiceProviderAppointmentSummary(AppointmentId: appointmentSummary.appointmentID.toString,
                                                 PrescriptionImageByteString: appointmentSummary.prescriptionImageByteString.toString,
                                                 PdfBytes: appointmentSummary.pdfbytes.mediaFile.value,
                                                 ReportsList: ServiceProviderReportMapper().grpcReportToLocal(report: appointmentSummary.reportsList.reports),
                                                 AppointmentTime: appointmentSummary.appointmentTime.toInt64,
                                                 AppointmentStatus: appointmentSummary.appointmentStatus.toString,
                                                 PrescriptionImagesUrl: appointmentSummary.prescriptionImagesURL.convert(),
                                                 ServiceRequest: ServiceProviderServiceRequestMapper().grpcServiceRequestToLocal(serviceRequest: appointmentSummary.serviceRequest),
                                                 Prescription: ServiceProviderPrescriptionMapper().grpcPrescriptionToLocal(prescription: appointmentSummary.prescription))
    }
    
    static func GrpcToLocal (appointmentSummary:[Nd_V1_ServiceProviderAppointmentSummaryMessage]) -> [ServiceProviderAppointmentSummary] {
        var summaries:[ServiceProviderAppointmentSummary] = [ServiceProviderAppointmentSummary]()
        
        for summary in appointmentSummary {
            summaries.append(GrpcToLocal(appointmentSummary: summary))
        }
        
        return summaries
    }
}
