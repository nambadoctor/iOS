//
//  DetailedDoctorMyPatientView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 6/9/21.
//

import SwiftUI

struct DetailedDoctorMyPatientView: View {
    
    @ObservedObject var MyPatientVM:MyPatientViewModel
    @State var takeToScheduleAppointment:Bool = false
    var body: some View {
        VStack {
            if self.MyPatientVM.appointmentSummaries.isEmpty {
                if self.MyPatientVM.noAppointments {
                    LargeButton(title: "Schedule Appointment") {
                        self.takeToScheduleAppointment.toggle()
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
                        self.takeToScheduleAppointment.toggle()
                    }
                    .padding(.horizontal)
                    ForEach(self.MyPatientVM.appointmentSummaries, id: \.AppointmentId) { summary in
                        AppointmentSummaryCardView(appointmentSummary: summary)
                        Divider()
                    }
                }
            }
            
            if takeToScheduleAppointment {
                NavigationLink("",
                               destination: ScheduleAppointmentForPatientView(scheduleAppointmentViewModel: self.MyPatientVM.scheduleAppointmentVM, showView: self.$takeToScheduleAppointment),
                               isActive: self.$takeToScheduleAppointment)
                    .onAppear() {self.MyPatientVM.scheduleAppointmentVM.availabilityVM.retrieveAvailabilities()}
            }
        }
    }
}

class MyPatientViewModel : ObservableObject {
    var patientProfile:ServiceProviderMyPatientProfile
    @Published var appointmentSummaries:[ServiceProviderAppointmentSummary] = [ServiceProviderAppointmentSummary]()
    @Published var noAppointments:Bool = false
    
    @Published var scheduleAppointmentVM:ScheduleAppointmentForPatientViewModel
    
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
}
