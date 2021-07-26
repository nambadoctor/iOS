//
//  ScheduleAppointmentForPatientView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 7/25/21.
//

import SwiftUI

struct ScheduleAppointmentForPatientView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var scheduleAppointmentViewModel:ScheduleAppointmentForPatientViewModel
    
    var body: some View {
        ScrollView {
            VStack (alignment: .leading) {
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
                    ServiceProviderReportsEntryView(reportsVM: ServiceProviderReportsEntryViewModel())
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .padding(.horizontal)
                
                
                AvailabilitySelector(availabilitySelectorVM: self.scheduleAppointmentViewModel.availabilityVM)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                LargeButton(title: "Confirm and Schedule Appointment") {
                    self.scheduleAppointmentViewModel.bookAppointment { success in
                        if success != nil {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
            }
        }
        .background(Color.gray.opacity(0.08))
    }
}
