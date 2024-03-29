//
//  DoctorViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 13/01/21.
//

import Foundation

class DoctorViewModel: ObservableObject {
    @Published var tabSelection:Int = 0
    @Published var doctor:ServiceProviderProfile!
    @Published var appointments:[ServiceProviderAppointment] = [ServiceProviderAppointment]()
    @Published var availabilities:[ServiceProviderAvailability] = [ServiceProviderAvailability]()
    @Published var myPatients:[ServiceProviderMyPatientProfile] = [ServiceProviderMyPatientProfile]()

    @Published var hasAppointments:Bool = false
    @Published var noPatients:Bool = false
    @Published var doctorLoggedIn:Bool = false
    
    @Published var takeToDetailedAppointment:Bool = false
    @Published var selectedAppointment:ServiceProviderAppointment? = nil

    @Published var showEdit:Bool = false
    @Published var editDoctorVM:EditServiceProviderViewModel = EditServiceProviderViewModel()
    @Published var availabilityVM:DoctorAvailabilityViewModel = DoctorAvailabilityViewModel()
    @Published var imageLoader:ImageLoader? = nil
    
    @Published var datePickerVM:DatePickerViewModel = DatePickerViewModel()

    var authenticateService:AuthenticateServiceProtocol
    var serviceProviderServiceCall:ServiceProviderProfileServiceProtocol
    var doctorAppointmentViewModel:ServiceProviderAppointmentServiceProtocol

    init(authenticateService:AuthenticateServiceProtocol = AuthenticateService(),
         serviceProviderServiceCall:ServiceProviderProfileServiceProtocol = ServiceProviderProfileService(),
         doctorAptVM:ServiceProviderAppointmentServiceProtocol = ServiceProviderAppointmentService()) {
        self.authenticateService = authenticateService
        self.serviceProviderServiceCall = serviceProviderServiceCall
        self.doctorAppointmentViewModel = doctorAptVM
        
        self.datePickerVM.datePickerDelegate = self
        
        fetchDoctor()
    }
    
    var serviceProviderName:String {
        return "\(doctor.firstName ?? "") \(doctor.lastName ?? "")"
    }
    

    func fetchDoctor () {
        let userId = UserIdHelper().retrieveUserId()
        serviceProviderServiceCall.getServiceProvider(serviceProviderId: userId) { (serviceProviderObj) in
            if serviceProviderObj != nil {
                self.doctor = serviceProviderObj!
                self.doctorLoggedIn = true
                self.retrieveAppointments()
                self.getMyPatients()
                self.updateFCMToken()
                if self.doctor.profilePictureURL != nil {
                    self.imageLoader = ImageLoader(urlString: self.doctor.profilePictureURL!) { success in }
                }
                self.availabilityVM.getAvailabilities(serviceProviderId: self.doctor.serviceProviderID)
            }
        }
    }

    func updateFCMToken () {
        //update FCM Token
        guard self.doctor != nil else { return
        }
        print("UPDATING TOKEN: \(DeviceTokenId)")
        if !DeviceTokenId.isEmpty {
            let appInfoID:String = self.doctor.applicationInfo?.appInfoID ?? ""
            ServiceProviderUpdateHelper().UpdateFCMToken(appInfoId: appInfoID, serviceProviderId: self.doctor.serviceProviderID) { response in
                if response != nil {
                    LoggerService().log(eventName: "SUCCESSFULLY UPDATED SERVICE PROVIDER FCM TOKEN")
                }
            }
        }
    }

    func updateDoctor () {
        self.doctor.serviceProviderDeviceInfo = DeviceHelper.getDeviceInfo()
        self.serviceProviderServiceCall.setServiceProvider(serviceProvider: self.doctor) { (response) in
            if response != nil {
                print("SERVICE PROVIDER UPDATE SUCCESS \(response)")
            }
            CommonDefaultModifiers.hideLoader()
        }
    }

    func retrieveAppointments () {
        CommonDefaultModifiers.showLoader(incomingLoadingText: "Getting your appointments")
        doctorAppointmentViewModel.getDocAppointments(serviceProviderId: doctor.serviceProviderID) { (appointments) in
            if appointments != nil {
                self.appointments.removeAll()
                self.appointments = appointments!
                self.datePickerVM.setDatesWithAppointments(appointments: appointments!)
                self.dateChanged(selectedDate: self.datePickerVM.selectedDate)
                CommonDefaultModifiers.hideLoader()
            }
            self.checkForEmptyList()
            self.getNotificationSelectedAppointment()
        }
    }

    func getNotificationSelectedAppointment () {
        for appointment in appointments {
            if docAutoNav.appointmentId == appointment.appointmentID {
                self.datePickerVM.selectedDate = Date(milliseconds: appointment.scheduledAppointmentEndTime)
                self.selectedAppointment = appointment
                self.takeToDetailedAppointment = true
            }
        }
    }

    func checkForEmptyList () {
        if appointments.isEmpty {
            self.hasAppointments = false
        }
    }

    func refreshAppointments () {
        self.retrieveAppointments()
    }
    
    func getMyPatients () {
        ServiceProviderCustomerService().getListOfPatients(serviceProviderId: self.doctor.serviceProviderID) { (listOfPatients) in

            if listOfPatients != nil && !(listOfPatients?.isEmpty ?? true){
                self.myPatients = listOfPatients!
            } else {
                print("HITTING THIS BRUH")
                self.noPatients = true
            }
        }
    }

    func commitEdits () {
        
        CommonDefaultModifiers.showLoader(incomingLoadingText: "Saving Profile")
        
        if editDoctorVM.imagePickerViewModel.image != nil {
            //upload to firebase and update url here...
        }
        
        if !editDoctorVM.AppointmentDuration.isEmpty {
            doctor.appointmentDuration = Int32(editDoctorVM.AppointmentDuration)!
        }
        
        if !editDoctorVM.ServiceFee.isEmpty {
            doctor.serviceFee = Double(editDoctorVM.ServiceFee)!
        }
        
        if !editDoctorVM.TimeIntervalBetweenAppointments.isEmpty {
            doctor.intervalBetweenAppointment = Int32(editDoctorVM.TimeIntervalBetweenAppointments)!
        }
        
        if !editDoctorVM.FollowUpServiceFee.isEmpty {
            doctor.followUpServiceFee = Double(editDoctorVM.FollowUpServiceFee)!
        }
        
        updateDoctor()
    }

}

extension DoctorViewModel : DatePickerChangedDelegate {
    func dateChanged(selectedDate: Date) {
        self.hasAppointments = checkIfAppointmentExistForDate(date: selectedDate)
    }

    func checkIfAppointmentExistForDate(date:Date) -> Bool {
        var exists:Bool = false
        for appoinment in appointments {
            let order = Calendar.current.compare(date, to: Date(milliseconds: appoinment.scheduledAppointmentStartTime), toGranularity: .day)
            
            if order == .orderedSame {
                exists = true
            }
        }
        return exists
    }
    
    func compareCurrentAppointmentTimeWithSelectedDate (appointment:ServiceProviderAppointment) -> Bool {
        return Helpers.compareDate(timestamp: appointment.scheduledAppointmentStartTime, date2: datePickerVM.selectedDate)
    }
}

extension DoctorViewModel : SelectAppointmentDelegate {
    func selectedAppointment(appointment: ServiceProviderAppointment) {
        self.selectedAppointment = appointment
        self.takeToDetailedAppointment = true
    }
}
