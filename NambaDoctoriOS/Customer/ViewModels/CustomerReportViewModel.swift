//
//  CustomerReportViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/28/21.
//

import Foundation

class CustomerReportViewModel : ObservableObject {
    @Published var report:CustomerReport
    @Published var imageLoader:ImageLoader? = nil
    @Published var displayImage:ImageDisplayEnum = .loading
    
    private var reportServiceCall:CustomerReportServiceProtocol
    
    init(report:CustomerReport,
         reportServiceCall:CustomerReportServiceProtocol = CustomerReportService()) {
        self.report = report
        self.reportServiceCall = reportServiceCall
        getImageObj()
    }

    func getImageObj () {
        reportServiceCall.getReportImage(reportId: report.reportID) { (reportImageURL) in
            if reportImageURL != nil {
                self.imageLoader = ImageLoader(urlString: reportImageURL!) { success in }
                self.displayImage = .display
            } else {
                self.displayImage = .notFound
            }
        }
    }
}
