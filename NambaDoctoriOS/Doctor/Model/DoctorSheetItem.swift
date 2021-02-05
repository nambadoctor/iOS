//
//  ShowSheetIdentifier.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 24/01/21.
//

import Foundation

var sheetTempItem:DoctorSheetItem? = nil

struct DoctorSheetItem:Identifiable {
    var id = UUID()
    
    //to show patient info sheet
    var appointment:Nambadoctor_V1_AppointmentObject?
    
    //to show add pre-reg patient sheet
    var showAddPatient:Bool?
}
