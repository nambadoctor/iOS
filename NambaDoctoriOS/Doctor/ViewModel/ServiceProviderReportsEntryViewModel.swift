//
//  ServiceProviderReportsEntryViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 7/25/21.
//

import Foundation
import SwiftUI

class ServiceProviderReportsEntryViewModel : ObservableObject {
    @Published var imagesToUpload:[Data] = [Data]()
    
    @Published var imagePickerVM:ImagePickerViewModel = ImagePickerViewModel()

    @Published var showUploadingIndicator:Bool = false
    
    @Published var showUploadReportSheet:Bool = false
    
    init() {
        imagePickerVM.imagePickerDelegate = self
    }
    func setReports(appointment:ServiceProviderAppointment, completion: @escaping (_ succcess:Bool) -> ()) {
        self.showUploadingIndicator = true
        CommonDefaultModifiers.showLoader(incomingLoadingText: "Uploading Reports")
        
        var reportsUploaded = 0
        func confirmUpload () {
            reportsUploaded += 1
            
            if reportsUploaded == imagesToUpload.count {
                CommonDefaultModifiers.hideLoader()
                completion(true)
            }
        }
        
        for report in imagesToUpload {
            
            let customerReport = ServiceProviderReportUploadObj(reportID: "", serviceRequestedID: appointment.serviceRequestID, customerID: appointment.customerID, fileName: "", name: "report", fileType: ".jpg", mediaFile: report.base64EncodedString())

            ServiceProviderReportService().setReport(report: customerReport, customerId: appointment.customerID, serviceRequestId: appointment.serviceRequestID) { success in
                if success {
                    confirmUpload()
                } else {
                    completion(false)
                }
            }
        }
        
    }
}

extension ServiceProviderReportsEntryViewModel : ImagePickedDelegate {
    func imageSelected() {
        LoggerService().log(eventName: "Image Selected To Upload")
        let image:UIImage = imagePickerVM.image!
        
        let encodedImage = image.jpegData(compressionQuality: 0.5)! //.base64EncodedString()
        
        self.imagesToUpload.append(encodedImage)
        
        print("WKEJFN \(self.imagesToUpload.count)")
    }
}
