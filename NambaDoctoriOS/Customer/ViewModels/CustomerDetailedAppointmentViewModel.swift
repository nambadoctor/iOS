//
//  CustomerDetailedAppointmentViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/29/21.
//

import Foundation
import SwiftUI

class CustomerDetailedAppointmentViewModel: ObservableObject {
    @Published var appointment:CustomerAppointment
    @Published var serviceRequest:CustomerServiceRequest? = nil
    @Published var reports:[CustomerReport] = [CustomerReport]()
    
    @Published var imagePickerVM:ImagePickerViewModel = ImagePickerViewModel()
    
    @Published var allergy:String = ""
    @Published var reason:String = ""
    
    var customerServiceRequestService:CustomerServiceRequestServiceProtocol
    var customerReportService:CustomerReportServiceProtocol
    
    init(appointment:CustomerAppointment,
         customerServiceRequestService:CustomerServiceRequestServiceProtocol = CustomerServiceRequestService(),
         customerReportService:CustomerReportServiceProtocol = CustomerReportService()) {
        
        self.appointment = appointment
        self.customerServiceRequestService = customerServiceRequestService
        self.customerReportService = customerReportService
        imagePickerVM.imagePickerDelegate = self
        
        self.getServiceRequest()
        self.getReports()
    }
    
    func getServiceRequest() {
        self.customerServiceRequestService.getServiceRequest(appointmentId: self.appointment.appointmentID,
                                                             serviceRequestId: self.appointment.serviceRequestID,
                                                             customerId: self.appointment.customerID) { serviceRequest in
            if serviceRequest != nil {
                print("SETTING SERVICE REQUEST")
                self.serviceRequest = serviceRequest!
                self.allergy = serviceRequest!.allergy.AllergyName
                self.reason = serviceRequest!.reason
            } else {
                //TODO: handle no service request returned
            }
        }
    }

    func getReports() {
        self.customerReportService.getAppointmentUploadedReportList(customerId: self.appointment.customerID, serviceRequestId: self.appointment.serviceRequestID, appointmentId: self.appointment.appointmentID) { reports in
            self.reports.removeAll()
            if reports != nil {
                self.reports = reports!
                CommonDefaultModifiers.hideLoader()
            } else {
                //TODO: handle empty reports list
            }
        }
    }

    func setReport(report:CustomerReportUpload) {
        CommonDefaultModifiers.showLoader()
        self.customerReportService.setReport(report: report) { success in
            if success {
                self.getReports()
            } else {
                //TODO: handle report upload failed
            }
        }
    }
}

extension CustomerDetailedAppointmentViewModel : ImagePickedDelegate {
    func imageSelected() {
        let image:UIImage = imagePickerVM.image!
        
        let encodedImage = image.jpegData(compressionQuality: 0.5)?.base64EncodedString()
        
        let customerReport = CustomerReportUpload(ReportId: "", ServiceRequestId: self.serviceRequest!.serviceRequestID, CustomerId: self.serviceRequest!.customerID, FileName: "", Name: "report", FileType: ".jpg", MediaFile: encodedImage!)
                
        setReport(report: customerReport)
    }
}
