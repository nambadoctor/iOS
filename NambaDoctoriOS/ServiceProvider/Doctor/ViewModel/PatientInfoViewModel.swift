//
//  PatientInfoViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 24/01/21.
//

import Foundation
import UIKit

class PatientInfoViewModel: ObservableObject {
    
    @Published var patientObj:ServiceProviderCustomerProfile!
    
    @Published var imagePickerVM:ImagePickerViewModel = ImagePickerViewModel()
    
    @Published var AppointmentList:[ServiceProviderAppointment]? = nil
    @Published var ReportList:[ServiceProviderReport]? = nil
    
    @Published var noReports:Bool = false
    
    var patientPhoneNumber:String = ""
    
    var appointment:ServiceProviderAppointment
    private var customerServiceCall:ServiceProviderCustomerServiceProtocol
    private var reportServiceCall:ServiceProviderReportServiceProtocol
    private var appointmentServiceCall:ServiceProviderAppointmentServiceProtocol
    
    init(appointment:ServiceProviderAppointment,
         reportServiceCall:ServiceProviderReportServiceProtocol = ServiceProviderReportService(),
         appointmentServiceCall:ServiceProviderAppointmentServiceProtocol = ServiceProviderAppointmentService(),
         customerServiceCall:ServiceProviderCustomerServiceProtocol = ServiceProviderCustomerService()) {
        
        self.appointment = appointment
        self.customerServiceCall = customerServiceCall
        self.reportServiceCall = reportServiceCall
        self.appointmentServiceCall = appointmentServiceCall
        
        self.imagePickerVM.imagePickerDelegate = self
        
        DispatchQueue.global().async {
            self.retrievePatientObj()
            self.retrieveAppointmentList()
        }
    }
    
    func callPatient () {
        callNumber(phoneNumber: self.patientPhoneNumber)
    }
    
    private func retrievePatientObj () {
        customerServiceCall.getPatientProfile(patientId: self.appointment.customerID) { (customer) in
            if customer != nil {
                self.patientObj = customer
                self.patientPhoneNumber = self.patientObj.phoneNumbers[0].countryCode + self.patientObj.phoneNumbers[0].number
                CommonDefaultModifiers.hideLoader()
            }
        }
    }
    
    private func retrieveAppointmentList () {
        appointmentServiceCall.getCustomerAppointmentList(patientId: appointment.customerID) { (aptList) in
            if aptList != nil {
                self.AppointmentList = aptList
            }
        }
    }
    
    func retrieveUploadedDocumentList (serviceRequestId:String) {
        self.ReportList?.removeAll()
        reportServiceCall.getUploadedReportList(customerId: appointment.customerID, serviceRequestId: serviceRequestId, appointmentId: appointment.appointmentID) { (uploadedDocumentList) in
            if uploadedDocumentList != nil {
                if uploadedDocumentList!.isEmpty {
                    self.noReports = true
                }
                self.ReportList = uploadedDocumentList
            } else {
                self.noReports = true
            }
        }
    }
    
    func getChildProfile (childId:String) -> ServiceProviderCustomerChildProfile? {
        
        for child in self.patientObj.children {
            if child.ChildProfileId == childId {
                self.patientPhoneNumber = child.PreferredPhoneNumber.mapToNumberString()
                return child
            }
        }
        
        return nil
    }
}

extension PatientInfoViewModel : ImagePickedDelegate {
    func imageSelected() {
        CommonDefaultModifiers.showLoader(incomingLoadingText: "Uploading Report")
        LoggerService().log(eventName: "Image Selected To Upload")
        let image:UIImage = imagePickerVM.image!
        
        let encodedImage = image.jpegData(compressionQuality: 0.5)! //.base64EncodedString()
        
        let customerReport = ServiceProviderReportUploadObj(reportID: "", serviceRequestedID: appointment.serviceRequestID, customerID: appointment.customerID, fileName: "", name: "report", fileType: ".jpg", mediaFile: encodedImage.base64EncodedString())

        ServiceProviderReportService().setReport(report: customerReport, customerId: appointment.customerID, serviceRequestId: appointment.serviceRequestID) { success in
            CommonDefaultModifiers.hideLoader()
            if success {
                self.retrieveUploadedDocumentList(serviceRequestId: self.appointment.serviceRequestID)
            } else {
                DoctorAlertHelpers().errorInUploadingReport { _ in }
            }
        }
    }
}
