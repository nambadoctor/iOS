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

    @Published var duration:String = ""

    @Published var frequency:String = ""
    @Published var routeOfAdmin:String = ""
    @Published var intake:String = ""

    @Published var morning:Double = 0.0
    @Published var afternoon:Double = 0.0
    @Published var evening:Double = 0.0
    @Published var night:Double = 0.0

    @Published var showEmptyWarningText:Bool = false

    var medicineEditedDelegate:MedicineEntryDelegate? = nil
    
    init(medicine:ServiceProviderMedicine, isNew:Bool, medicineEditedDelegate:MedicineEntryDelegate) {
        if !isNew {
            mapExistingMedicine(medicine: medicine)
        }
        self.medicineEditedDelegate = medicineEditedDelegate
    }
    
    func toggleEmptyWarning () {
        guard medicineName.isEmpty, dosage.isEmpty else { return }
        showEmptyWarningText = true
    }

    func mapExistingMedicine(medicine:ServiceProviderMedicine) {
        medicineName = medicine.medicineName
        dosage = medicine.dosage

        if medicine.duration == 0 {
            duration = String(medicine.duration)
        }
        
        frequency = medicine.specialInstructions
        routeOfAdmin = medicine.routeOfAdministration
        intake = medicine.intake
    }

    func clearValues () {
        medicineName = ""
        dosage = ""
        duration = ""
        intake = ""
        routeOfAdmin = ""
        frequency = ""
    }
    
    func makeMedObjAndAdd() {
        medicineEditedDelegate?.addMedicine()
    }
}
