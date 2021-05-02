//
//  CustomerDetailedAppointmentViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 4/29/21.
//

import Foundation
import SwiftUI
import PDFKit

class CustomerDetailedAppointmentViewModel: ObservableObject {
    @Published var appointment:CustomerAppointment
    @Published var serviceRequest:CustomerServiceRequest? = nil
    @Published var prescription:CustomerPrescription? = nil
    @Published var reports:[CustomerReport] = [CustomerReport]()
    
    @Published var imagePickerVM:ImagePickerViewModel = ImagePickerViewModel()
    @Published var customerTwilioViewModel:CustomerTwilioViewModel
    @Published var customerChatViewModel:CustomerChatViewModel
    
    @Published var allergy:String = ""
    @Published var reason:String = ""
    
    @Published var prescriptionPDF:Data? = nil
    @Published var imageLoader:ImageLoader? = nil
    
    @Published var showTwilioRoom:Bool = false
    @Published var takeToChat:Bool = false
    
    var customerServiceRequestService:CustomerServiceRequestServiceProtocol
    var customerReportService:CustomerReportServiceProtocol
    
    init(appointment:CustomerAppointment,
         customerServiceRequestService:CustomerServiceRequestServiceProtocol = CustomerServiceRequestService(),
         customerReportService:CustomerReportServiceProtocol = CustomerReportService()) {
        
        self.appointment = appointment
        self.customerServiceRequestService = customerServiceRequestService
        self.customerReportService = customerReportService
        self.customerTwilioViewModel = CustomerTwilioViewModel(appointment: appointment)
        self.customerChatViewModel = CustomerChatViewModel(appointment: appointment)
        imagePickerVM.imagePickerDelegate = self
        
        self.getServiceRequest()
        self.getPrescription()
        self.getPrescriptionPDF()
        self.getReports()
    }
    
    func getServiceRequest() {
        self.customerServiceRequestService.getServiceRequest(appointmentId: self.appointment.appointmentID,
                                                             serviceRequestId: self.appointment.serviceRequestID,
                                                             customerId: self.appointment.customerID) { serviceRequest in
            if serviceRequest != nil {
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
    
    func getPrescription() {
        CustomerPrescriptionService().getPrescription(customerId: UserIdHelper().retrieveUserId(), serviceRequestId: appointment.serviceRequestID, appointmentId: appointment.appointmentID) { prescription in
            guard prescription != nil else { return }

            if prescription!.medicineList.count != 0 {
                self.getPrescriptionPDF()
            }
            
            if !prescription!.fileInfo.FileType.isEmpty {
                self.getPrescription()
            }
        }
    }
    
    func getPrescriptionPDF () {
        CustomerPrescriptionService().getPrescriptionPDF(serviceProviderId: appointment.serviceProviderID, customerId: appointment.customerID, appointmentId: appointment.appointmentID, serviceRequestId: appointment.serviceRequestID) { data in
            if data != nil {
                self.prescriptionPDF = data!
            }
        }
    }
    
    func getPrescriptionImage () {
        CustomerPrescriptionService().downloadPrescription(prescriptionID: prescription!.prescriptionID) { url in
            if url != nil {
                self.imageLoader = ImageLoader(urlString: url!) { success in
                    if !success {
                        self.imageLoader = nil
                    } else {
                        //self.showRemoveButton = true
                    }
                }
            }
        }
    }
    
    func startConsultation() {
        CommonDefaultModifiers.showLoader()
        customerTwilioViewModel.startRoom() { success in
            if success {
                self.showTwilioRoom = true
                CommonDefaultModifiers.hideLoader()
            } else {
                
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
