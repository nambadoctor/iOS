//
//  MedicineEntryViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 22/01/21.
//

import Foundation

protocol MedicineEntryDelegate {
    func addMedicine()
}

class MedicineEntryViewModel : ObservableObject {
    @Published var medicineName:String = ""
    @Published var dosage:String = ""

    @Published var noSpecificDuration:Bool = false
    @Published var tempNumOfDays:String = ""
    @Published var timeIndex = 0

    @Published var frequency:String = ""
    @Published var routeOfAdmin:String = ""
    @Published var intake:String = ""
    
    @Published var showEmptyWarningText:Bool = false
    
    var medicineEditedDelegate:MedicineEntryDelegate? = nil
    
    init(medicine:ServiceProviderMedicine, isNew:Bool) {
        if !isNew {
            mapExistingMedicine(medicine: medicine)
        }
    }
    
    func toggleEmptyWarning () {
        guard medicineName.isEmpty, dosage.isEmpty else { return }
        showEmptyWarningText = true
    }

    func mapExistingMedicine(medicine:ServiceProviderMedicine) {
        medicineName = medicine.medicineName
        dosage = medicine.dosage

        if medicine.duration == 0 {
            noSpecificDuration = true
        } else {
            tempNumOfDays = String(medicine.duration)
            timeIndex = 0
        }
        
        frequency = medicine.specialInstructions
        routeOfAdmin = medicine.routeOfAdministration
        intake = medicine.intake
    }

    func clearValues () {
        medicineName = ""
        dosage = ""
        noSpecificDuration = false
        tempNumOfDays = ""
        timeIndex = 0
        intake = ""
        routeOfAdmin = ""
        frequency = ""
    }
    
    func makeMedObjAndAdd() {
        medicineEditedDelegate?.addMedicine()
    }
}
