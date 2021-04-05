//
//  DoctorViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 13/01/21.
//

import Foundation

class DoctorViewModel: ObservableObject {
    @Published var doctor:ServiceProviderProfile!
    @Published var appointments:[ServiceProviderAppointment] = [ServiceProviderAppointment]()
    @Published var myPatients:[ServiceProviderCustomerProfile] = [ServiceProviderCustomerProfile]()
    
    @Published var noAppointments:Bool = false
    @Published var noPatients:Bool = false
    @Published var doctorLoggedIn:Bool = false
    
    @Published var showEdit:Bool = false
    @Published var editDoctorVM:EditServiceProviderViewModel = EditServiceProviderViewModel()
    @Published var imageLoader:ImageLoader? = nil
    
    @Published var datePickerVM:DatePickerViewModel = DatePickerViewModel()
    @Published var noAppointmentsForSelectedDate:Bool = false
    
    var authenticateService:AuthenticateServiceProtocol
    var serviceProviderServiceCall:ServiceProviderGetSetServiceCallProtocol
    var doctorAppointmentViewModel:AppointmentGetSetServiceCallProtocol
    
    init(authenticateService:AuthenticateServiceProtocol = AuthenticateService(),
         serviceProviderServiceCall:ServiceProviderGetSetServiceCallProtocol = ServiceProviderGetSetServiceCall(),
         doctorAptVM:AppointmentGetSetServiceCallProtocol = AppointmentGetSetServiceCall()) {
        self.authenticateService = authenticateService
        self.serviceProviderServiceCall = serviceProviderServiceCall
        self.doctorAppointmentViewModel = doctorAptVM
        
        self.datePickerVM.datePickerDelegate = self
        
        fetchDoctor()
    }
    
    func fetchDoctor () {
        let userId = authenticateService.getUserId()
        serviceProviderServiceCall.getServiceProvider(serviceProviderId: userId) { (serviceProviderObj) in
            if serviceProviderObj != nil {
                self.doctor = serviceProviderObj!
                self.doctorLoggedIn = true
                self.retrieveAppointments()
                self.getMyPatients()
                self.updateFCMToken()
                self.imageLoader = ImageLoader(urlString: self.doctor.profilePictureURL) { success in }
            }
        }
    }
    
    func updateFCMToken () {
        //update FCM Token
        guard self.doctor != nil else { return
        }
        if !FCMTokenId.isEmpty {
            self.doctor.applicationInfo.deviceToken = FCMTokenId
            self.updateDoctor()
        }
    }
    
    func updateDoctor () {
        DispatchQueue.global().async {
            self.serviceProviderServiceCall.setServiceProvider(serviceProvider: self.doctor) { (response) in
                if response != nil {
                    print("SERVICE PROVIDER UPDATE SUCCESS \(response)")
                }
                DispatchQueue.main.async {
                    CommonDefaultModifiers.hideLoader()
                }
            }
        }
    }
    
    var authTokenId:String? {
        return doctor.applicationInfo.authID
    }
    
    var fcmTokenId:String? {
        return doctor.applicationInfo.deviceToken
    }
    
    func retrieveAppointments () {
        doctorAppointmentViewModel.getDocAppointments(serviceProviderId: doctor.serviceProviderID) { (appointments) in
            if appointments != nil {
                self.appointments = appointments!
                self.datePickerVM.setDatesWithAppointments(appointments: appointments!)
            }
            self.checkForEmptyList()
        }
    }
    
    func checkForEmptyList () {
        if appointments.isEmpty {
            self.noAppointments = true
        }
    }
    
    func refreshAppointments () {
        self.appointments.removeAll()
        self.retrieveAppointments()
    }
    
    func getMyPatients () {
        serviceProviderServiceCall.getListOfPatients(serviceProviderId: self.doctor.serviceProviderID) { (listOfPatients) in
            if listOfPatients != nil {
                self.myPatients = listOfPatients!
            } else {
                self.noPatients = true
            }
        }
    }
    
    func commitEdits () {
        
        CommonDefaultModifiers.showLoader()
        
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
        self.noAppointmentsForSelectedDate = checkIfAppointmentExistForDate(date: selectedDate)
    }
    
    func checkIfAppointmentExistForDate(date:Date) -> Bool {
        var exists:Bool = true
        for appoinment in appointments {
            let order = Calendar.current.compare(date, to: Date(milliseconds: appoinment.scheduledAppointmentStartTime), toGranularity: .day)
            
            if order == .orderedSame {
                exists = false
            }
        }
        
        return exists
    }
    
    func compareCurrentAppointmentTimeWithSelectedDate (appointment:ServiceProviderAppointment) -> Bool {
        return Helpers.compareDate(timestamp: appointment.scheduledAppointmentStartTime, date2: datePickerVM.selectedDate)
    }
}
