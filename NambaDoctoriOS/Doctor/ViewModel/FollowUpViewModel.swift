//
//  FollowUpViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 3/31/21.
//

import Foundation

class FollowUpViewModel : ObservableObject {
    @Published var toggleFollowUp:Bool = false
    @Published var followUpDays:String = ""
    @Published var daysArr:[String] = ["Days", "Weeks", "Months"]
    @Published var selectedDay:String = ""
}
