//
//  CustomerAllReportsViewModek.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/15/21.
//

import Foundation
import SwiftUI

class CustomerAllReportsViewModel : ObservableObject {
    @Published var reports:[CustomerReport] = [CustomerReport]()
    var customerReportService:CustomerReportServiceProtocol
    var appointment:CustomerAppointment
    var customerNotifHelpers:CustomerNotificationHelper
    
    @Published var imagePickerVM:ImagePickerViewModel = ImagePickerViewModel()
    
    @Published var showUploadingIndicator:Bool = false
    
    @Published var showUploadReportSheet:Bool = false
    
    init(customerReportService:CustomerReportServiceProtocol = CustomerReportService(),
         appointment:CustomerAppointment) {
        self.customerReportService = customerReportService
        self.appointment = appointment
        self.customerNotifHelpers = CustomerNotificationHelper(appointment: appointment)
        imagePickerVM.imagePickerDelegate = self

        getReports()
        checkIfFirstTimeOpeningAppointment()
    }

    func getReports() {
        self.customerReportService.getAppointmentUploadedReportList(customerId: self.appointment.customerID, serviceRequestId: self.appointment.serviceRequestID, appointmentId: self.appointment.appointmentID) { reports in
            self.reports.removeAll()
            if reports != nil {
                self.reports = reports!
                CommonDefaultModifiers.hideLoader()
                self.showUploadingIndicator = false
            } else {
                //TODO: handle empty reports list
            }
        }
    }
    
    func setReport(report:CustomerReportUpload) {
        self.showUploadingIndicator = true
        CommonDefaultModifiers.showLoader(incomingLoadingText: "Uploading Report")
        self.customerReportService.setReport(report: report) { success in
            if success {
                self.getReports()
                self.customerNotifHelpers.reportUploadedNotif()
            } else {
                //TODO: handle report upload failed
            }
        }
    }
}

extension CustomerAllReportsViewModel : ImagePickedDelegate {
    func imageSelected() {
        let image:UIImage = imagePickerVM.image!
        
        let encodedImage = image.jpegData(compressionQuality: 0.5)?.base64EncodedString()
        
        let customerReport = CustomerReportUpload(ReportId: "", ServiceRequestId: self.appointment.serviceRequestID, CustomerId: self.appointment.customerID, FileName: "", Name: "report", FileType: ".jpg", MediaFile: encodedImage!)
        
        setReport(report: customerReport)
    }
    
    func dontShowUploadReportSheetAnymore () {
        UserDefaults.standard.set(true, forKey: self.appointment.appointmentID)
        self.showUploadReportSheet = false
    }

    func checkIfFirstTimeOpeningAppointment () {
        self.showUploadReportSheet = !UserDefaults.standard.bool(forKey: self.appointment.appointmentID)
    }
}
