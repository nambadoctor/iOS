//
//  PatientReportViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 05/02/21.
//

import Foundation
import UIKit

class PatientReportViewModel : ObservableObject {
    @Published var report:Report
    @Published var mediaObject:UIImage?
    @Published var displayImage:ImageDisplayEnum = .loading
    
    private var retrievePatientInfo:RetrievePatientInfoProtocol
    
    init(report:Report,
         retrievePatientInfo:RetrievePatientInfoProtocol = RetrievePatientInfoViewModel()) {
        self.report = report
        self.retrievePatientInfo = retrievePatientInfo
        
        getImageObj()
    }
    
    func getImageObj () {
        retrievePatientInfo.getReportImage(reportId: report.id) { (reportImage) in
            if reportImage != nil {
                self.mediaObject = reportImage
                self.displayImage = .display
            } else {
                self.displayImage = .notFound
            }
        }
    }
}
