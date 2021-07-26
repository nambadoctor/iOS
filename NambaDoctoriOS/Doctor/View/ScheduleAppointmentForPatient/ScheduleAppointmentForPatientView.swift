//
//  ScheduleAppointmentForPatientView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 7/25/21.
//

import SwiftUI

struct ScheduleAppointmentForPatientView: View {
    @ObservedObject var scheduleAppointmentViewModel:ScheduleAppointmentForPatientViewModel
    @Binding var showView:Bool
    var body: some View {
        ZStack {
            ScrollView {
                VStack (alignment: .leading) {
                    
                    AvailabilitySelector(availabilitySelectorVM: self.scheduleAppointmentViewModel.availabilityVM)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                    
                    Text("CUSTOMER VITALS")
                        .padding(.horizontal)
                    VStack (alignment: .leading) {
                        CustomerVitalsEntryView(customerVitalsVM: self.scheduleAppointmentViewModel.customerVitalsViewModel)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
                    
                    VStack (alignment: .leading) {
                        ServiceProviderReportsEntryView(reportsVM: self.scheduleAppointmentViewModel.reportUploadVM)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.horizontal)

                    LargeButton(title: "Confirm and Schedule Appointment") {
                        self.scheduleAppointmentViewModel.bookAppointment { success in
                            if success != nil {
                                self.showView = false
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .background(Color.gray.opacity(0.08))
        }
    }
}
