//
//  EditServiceProviderViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 3/28/21.
//

import Foundation

class EditServiceProviderViewModel : ObservableObject {
        
    //doctor core details
    @Published var imagePickerViewModel : ImagePickerViewModel = ImagePickerViewModel()
    
    //appointment details
    @Published var AppointmentDuration:String = ""
    @Published var ServiceFee:String = ""
    @Published var TimeIntervalBetweenAppointments:String = ""
    @Published var FollowUpServiceFee:String = ""
}

