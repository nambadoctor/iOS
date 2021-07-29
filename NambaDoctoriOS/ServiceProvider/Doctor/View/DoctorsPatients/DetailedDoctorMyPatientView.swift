//
//  DetailedDoctorMyPatientView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 6/9/21.
//

import SwiftUI

struct DetailedDoctorMyPatientView: View {

    @ObservedObject var MyPatientVM:MyPatientViewModel
    
    var body: some View {
        VStack {
            if self.MyPatientVM.appointmentSummaries.isEmpty {
                if self.MyPatientVM.noAppointments {
                    LargeButton(title: "Schedule Appointment") {
                        self.MyPatientVM.takeToScheduleAppointment()
                    }
                    Spacer()
                    Text("No Appointments For This Patient")
                    Spacer()
                } else {
                    Indicator()
                }
            } else {
                ScrollView {
                    LargeButton(title: "Schedule Appointment") {
                        self.MyPatientVM.takeToScheduleAppointment()
                    }
                    .padding(.horizontal)
                    ForEach(self.MyPatientVM.appointmentSummaries, id: \.AppointmentId) { summary in
                        AppointmentSummaryCardView(appointmentSummary: summary)
                        Divider()
                    }
                }
            }
            
            if MyPatientVM.takeToScheduleAppointmentView {
                NavigationLink("",
                               destination: ScheduleAppointmentForPatientView(scheduleAppointmentViewModel: self.MyPatientVM.scheduleAppointmentVM, showView: self.$MyPatientVM.takeToScheduleAppointmentView),
                               isActive: self.$MyPatientVM.takeToScheduleAppointmentView)
                    .onAppear() {self.MyPatientVM.scheduleAppointmentVM.availabilityVM.retrieveAvailabilities()}
            }
        }
        .sheet(isPresented: self.$MyPatientVM.showSelectDoctorView, content: {
            SelectServiceProvidersView(organisationServiceProvidersVM: self.MyPatientVM.makeOrganisationsServiceProvidersViewModel())
        })
        .onAppear() {
            self.MyPatientVM.getAppointmentSummaries()
        }
    }
}

class MyPatientViewModel : ObservableObject {
    var patientProfile:ServiceProviderMyPatientProfile
    @Published var appointmentSummaries:[ServiceProviderAppointmentSummary] = [ServiceProviderAppointmentSummary]()
    @Published var noAppointments:Bool = false
    @Published var takeToScheduleAppointmentView:Bool = false
    
    @Published var scheduleAppointmentVM:ScheduleAppointmentForPatientViewModel
    
    var doctorToBook:ServiceProviderProfile? = nil
    @Published var showSelectDoctorView:Bool = false
    
    var organisation:ServiceProviderOrganisation?
    var serviceProvider:ServiceProviderProfile

    init(patientProfile:ServiceProviderMyPatientProfile, organisation:ServiceProviderOrganisation?, serviceProvider:ServiceProviderProfile) {
        self.organisation = organisation
        self.serviceProvider = serviceProvider
        self.patientProfile = patientProfile
        
        self.scheduleAppointmentVM = ScheduleAppointmentForPatientViewModel(organisation: organisation, serviceProvider: serviceProvider, customer: patientProfile, finishedCallback: nil)
        
        getAppointmentSummaries()
    }
    
    func getAppointmentSummaries () {
        ServiceProviderCustomerService().getAppointmentSummary(parentCustomerId: patientProfile.IsChild ? patientProfile.CareTakerId : patientProfile.CustomerId,
                                                               serviceProviderId: UserIdHelper().retrieveUserId(),
                                                               childId: patientProfile.IsChild ? patientProfile.CustomerId : "") { summaries in
            if summaries != nil && !summaries!.isEmpty {
                self.appointmentSummaries = summaries!.sorted(by: { $0.AppointmentTime > $1.AppointmentTime })
            } else {
                self.noAppointments = true
            }
        }
    }
    
    func takeToScheduleAppointment () {
        if serviceProvider.serviceProviderType == "Secretary" {
            self.showSelectDoctorView = true
        } else {
            self.takeToScheduleAppointmentView.toggle()
        }
    }
    
    func selectDoctor (doctor:ServiceProviderProfile) {
        self.showSelectDoctorView = false
        self.doctorToBook = doctor
        self.scheduleAppointmentVM = ScheduleAppointmentForPatientViewModel(organisation: self.organisation, serviceProvider: self.doctorToBook!, customer: self.patientProfile, finishedCallback: nil)
        self.takeToScheduleAppointmentView = true
    }
    
    func makeOrganisationsServiceProvidersViewModel() -> OrganisationsServiceProvidersViewModel {
        return OrganisationsServiceProvidersViewModel(orgId: self.organisation?.organisationId ?? "", callBack: selectDoctor)
    }
}
