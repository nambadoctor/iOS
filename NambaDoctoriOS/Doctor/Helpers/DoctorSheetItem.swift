//
//  DoctorSheetItem.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 05/02/21.
//

import Foundation

var sheetTempItem:DoctorSheetItem? = nil

struct DoctorSheetItem:Identifiable {
    var id = UUID()
    
    //to show patient info sheet
    var appointment:Appointment?
    
    //to show add pre-reg patient sheet
    var showAddPatient:Bool?
}
