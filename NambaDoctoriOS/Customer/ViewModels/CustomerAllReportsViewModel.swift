//
//  CustomerAllReportsViewModek.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 5/15/21.
//

import Foundation

class CustomerAllReportsViewModel : ObservableObject {
    @Published var reports:[CustomerReport] = [CustomerReport]()
    var customerReportService:CustomerReportServiceProtocol
    var appointment:CustomerAppointment
    var customerNotifHelpers:CustomerNotificationHelper
    
    init(customerReportService:CustomerReportServiceProtocol = CustomerReportService(),
         appointment:CustomerAppointment) {
        self.customerReportService = customerReportService
        self.appointment = appointment
        self.customerNotifHelpers = CustomerNotificationHelper(appointment: appointment)
        
        getReports()
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
                self.customerNotifHelpers.reportUploadedNotif()
            } else {
                //TODO: handle report upload failed
            }
        }
    }
}
