//
//  PatientReportViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 05/02/21.
//

import Foundation
import UIKit

class PatientReportViewModel : ObservableObject {
    @Published var report:ServiceProviderReport
    @Published var mediaObject:UIImage?
    @Published var displayImage:ImageDisplayEnum = .loading
    
    private var reportServiceCall:ReportGetSetServiceCallProtocol
    
    init(report:ServiceProviderReport,
         reportServiceCall:ReportGetSetServiceCallProtocol = ReportGetSetServiceCall()) {
        self.report = report
        self.reportServiceCall = reportServiceCall
        
        getImageObj()
    }
    
    func getImageObj () {
        reportServiceCall.getReportImage(reportId: report.reportID) { (reportImage) in
            if reportImage != nil {
                self.mediaObject = reportImage
                self.displayImage = .display
            } else {
                self.displayImage = .notFound
            }
        }
    }
}
