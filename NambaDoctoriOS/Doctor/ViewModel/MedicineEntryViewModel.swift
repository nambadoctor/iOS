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
//    @Published var mgOrmcg:String = "mg"

    @Published var duration:String = ""

    @Published var frequency:String = ""
    @Published var routeOfAdmin:String = ""
    @Published var intake:String = ""
    
    @Published var wheneverNecessary:Bool = false

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
        duration = String(medicine.duration)
        dosage = medicine.dosage
        frequency = medicine.specialInstructions
        routeOfAdmin = medicine.routeOfAdministration
        intake = medicine.intake
        
        if !medicine.timings.isEmpty {
            let timingsSplit = medicine.timings.components(separatedBy: ",")
            morning = Double(timingsSplit[0]) ?? 0.0
            afternoon = Double(timingsSplit[1]) ?? 0.0
            evening = Double(timingsSplit[2]) ?? 0.0
            night = Double(timingsSplit[3]) ?? 0.0
        } else {
            wheneverNecessary = true
            morning = 0
            afternoon = 0
            evening = 0
            night = 0
        }
    }

    func clearValues () {
        medicineName = ""
        dosage = ""
        duration = ""
        intake = ""
        routeOfAdmin = ""
        frequency = ""
        wheneverNecessary = false
    }
    
    func makeMedObjAndAdd() {
        medicineEditedDelegate?.addMedicine()
    }
}
