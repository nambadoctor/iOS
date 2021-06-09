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
        ScrollView {
            ForEach(self.MyPatientVM.appointmentSummaries, id: \.AppointmentId) { summary in
                AppointmentSummaryCardView(appointmentSummary: summary)
                Divider()
            }
        }
    }
}

class MyPatientViewModel : ObservableObject {
    var patientProfile:ServiceProviderMyPatientProfile
    @Published var appointmentSummaries:[ServiceProviderAppointmentSummary] = [ServiceProviderAppointmentSummary]()
    
    init(patientProfile:ServiceProviderMyPatientProfile) {
        self.patientProfile = patientProfile
        getAppointmentSummaries()
    }
    
    func getAppointmentSummaries () {
        ServiceProviderCustomerService().getAppointmentSummary(parentCustomerId: patientProfile.IsChild ? patientProfile.CareTakerId : patientProfile.CustomerId,
                                                               serviceProviderId: UserIdHelper().retrieveUserId(),
                                                               childId: patientProfile.IsChild ? patientProfile.CustomerId : "") { summaries in
            if summaries != nil {
                self.appointmentSummaries = summaries!.sorted(by: { $0.AppointmentTime > $1.AppointmentTime })
            }
        }
    }
}
