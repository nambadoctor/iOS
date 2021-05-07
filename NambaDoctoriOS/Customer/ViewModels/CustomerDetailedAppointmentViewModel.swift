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
    @Published var serviceProvider:CustomerServiceProviderProfile? = nil
    
    @Published var imagePickerVM:ImagePickerViewModel = ImagePickerViewModel()
    @Published var customerTwilioViewModel:CustomerTwilioViewModel
    @Published var customerChatViewModel:CustomerChatViewModel
    
    @Published var allergy:String = "No"
    @Published var reasonPickerVM:ReasonPickerViewModel = ReasonPickerViewModel()
    
    @Published var prescriptionPDF:Data? = nil
    @Published var imageLoader:ImageLoader? = nil
    @Published var docProfPicImageLoader:ImageLoader? = nil
    
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
        reasonPickerVM.reasonPickedDelegate = self
        
        self.getServiceProvider()
        self.getServiceRequest()
        self.getReports()
        
        if appointmentFinished {
            self.getPrescription()
        }
    }

    var appointmentStarted:Bool {
        if appointment.status == ConsultStateK.StartedConsultation.rawValue {
            return true
        } else {
            return false
        }
    }
    
    var appointmentFinished:Bool {
        if appointment.status == ConsultStateK.Finished.rawValue ||
                    appointment.status == ConsultStateK.FinishedAppointment.rawValue {
            return true
        } else {
            return false
        }
    }
    
    var appointmnentUpComing:Bool {
        if appointment.status == ConsultStateK.Confirmed.rawValue {
            return true
        } else {
            return false
        }
    }
    
    var appointmentScheduledStartTime:String {
        return "\(Helpers.getTimeFromTimeStamp(timeStamp: appointment.scheduledAppointmentStartTime))"
    }
    
    var appointmentScheduledEndTime:String {
        return "\(Helpers.getTimeFromTimeStamp(timeStamp: appointment.scheduledAppointmentEndTime))"
    }
    
    var appointmentActualStartTime:String {
        return "\(Helpers.getTimeFromTimeStamp(timeStamp: appointment.actualAppointmentStartTime))"
    }
    
    var appointmentActualEndTime:String {
        return "\(Helpers.getTimeFromTimeStamp(timeStamp: appointment.actualAppointmentEndTime))"
    }
    
    var serviceProviderName : String {
        return "Dr. \(appointment.serviceProviderName)"
    }
    
    var serviceProviderFee : String {
        return "Fee: \(appointment.serviceFee.clean)"
    }
    
    func getServiceRequest() {
        self.customerServiceRequestService.getServiceRequest(appointmentId: self.appointment.appointmentID,
                                                             serviceRequestId: self.appointment.serviceRequestID,
                                                             customerId: self.appointment.customerID) { serviceRequest in
            if serviceRequest != nil {
                self.serviceRequest = serviceRequest!
                self.allergy = serviceRequest!.allergy.AllergyName
                
                if !serviceRequest!.reason.isEmpty {
                    self.reasonPickerVM.reason = serviceRequest!.reason
                    self.reasonPickerVM.reasonSelected()
                }
                
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
    
    func getServiceProvider () {
        CustomerServiceProviderService().getServiceProvider(serviceProviderId: appointment.serviceProviderID) { provider in
            if provider != nil {
                self.serviceProvider = provider!
                self.docProfPicImageLoader = ImageLoader(urlString: provider!.profilePictureURL) { _ in }
            }
        }
    }
    
    func getPrescription() {
        CustomerPrescriptionService().getPrescription(customerId: UserIdHelper().retrieveUserId(), serviceRequestId: appointment.serviceRequestID, appointmentId: appointment.appointmentID) { prescription in
            
            if prescription != nil {
                self.prescription = prescription!

                self.getPrescriptionPDF()

                self.getPrescriptionImage()
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
    
    func cancelAppointment(completion: @escaping (_ successfullyCancelled:Bool)->()) {
        DoctorAlertHelpers().cancelAppointmentAlert { (cancel) in
            CommonDefaultModifiers.showLoader()
            CustomerUpdateAppointmentStatusHelper().toCancelled(appointment: &self.appointment) { (success) in
                if success {
                    //TODO: Fire cancelled notification
                    CommonDefaultModifiers.hideLoader()
                    completion(success)
                } else {
                    GlobalPopupHelpers.setErrorAlert()
                    CommonDefaultModifiers.hideLoader()
                    completion(success)
                }
            }
        }
    }
    
    func setServiceRequest () {
        self.serviceRequest!.allergy.AllergyName = self.allergy
        self.serviceRequest!.allergy.AppointmentId = self.appointment.appointmentID
        self.serviceRequest!.allergy.ServiceRequestId = self.serviceRequest!.serviceRequestID
        
        self.serviceRequest!.reason = self.reasonPickerVM.reason
        
        customerServiceRequestService.setServiceRequest(serviceRequest: self.serviceRequest!) { response in
            if response != nil {
                print("success")
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

extension CustomerDetailedAppointmentViewModel : SideBySideCheckBoxDelegate {
    func itemChecked(value: String) {
        self.allergy = value
        self.setServiceRequest()
    }
}

extension CustomerDetailedAppointmentViewModel : ReasonPickedDelegate {
    func reasonSelected(reason: String) {
        self.setServiceRequest()
    }
}
