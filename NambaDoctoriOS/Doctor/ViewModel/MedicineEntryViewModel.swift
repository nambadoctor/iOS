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

class AutoFillMedicineVM: ObservableObject {
    @Published var autofillMedicineList:[ServiceProviderAutofillMedicine] = [ServiceProviderAutofillMedicine]()
    @Published var predictedMedicineList:[ServiceProviderAutofillMedicine] = [ServiceProviderAutofillMedicine]()
    
    init() {
        getAutofillMedicines()
    }

    func getAutofillMedicines () {
        ServiceProviderProfileService().getAutofillMedicineList { autoFillMedList in
            if autoFillMedList != nil {
                DispatchQueue.main.async {
                    self.autofillMedicineList = autoFillMedList!
                    self.predictedMedicineList = autoFillMedList!
                }
            }
        }
    }
}

class MedicineEntryViewModel : ObservableObject {
    @Published var medicineName:String = ""
    @Published var medicineNameChanged:Bool = false
    @Published var medicineNameConfirmed:Bool = false

    @Published var dosage:ServiceProviderIntakeDosage = MakeEmptyDosage()

    @Published var duration:ServiceProviderDuration = MakeEmptyDuration()

    @Published var frequency:String = ""
    @Published var routeOfAdmin:String = ""
    @Published var intake:String = ""
    @Published var notes:String = ""
    
    @Published var wheneverNecessary:Bool = false

    @Published var morning:Double = 0.0
    @Published var afternoon:Double = 0.0
    @Published var night:Double = 0.0

    @Published var showEmptyWarningText:Bool = false

    var medicineEditedDelegate:MedicineEntryDelegate? = nil
    
    @Published var autoFillVM:AutoFillMedicineVM
    @Published var showPredictedMedicines:Bool = false
    
    @Published var isFirstResponder:Bool = true
    
    init(medicine:ServiceProviderMedicine,
         isNew:Bool,
         medicineEditedDelegate:MedicineEntryDelegate,
         autoFillVM:AutoFillMedicineVM) {
        self.medicineEditedDelegate = medicineEditedDelegate
        self.autoFillVM = autoFillVM
        
        if !isNew {
            self.isFirstResponder = false
            mapExistingMedicine(medicine: medicine)
        }
    }
    
    func toggleEmptyWarning () {
        guard medicineName.isEmpty, dosage.Name.isEmpty else { return }
        showEmptyWarningText = true
    }

    func mapExistingMedicine(medicine:ServiceProviderMedicine) {
        medicineName = medicine.medicineName
        dosage = medicine.intakeDosage
        duration = medicine._duration
        frequency = medicine.specialInstructions
        routeOfAdmin = medicine.routeOfAdministration
        notes = medicine.notes
        intake = medicine.intake
        if !medicine.timings.isEmpty {
            let timingsSplit = medicine.timings.components(separatedBy: ",")
            morning = Double(timingsSplit[0]) ?? 0.0
            afternoon = Double(timingsSplit[1]) ?? 0.0
            night = Double(timingsSplit[2]) ?? 0.0
            
            if timingsSplit.count == 4 {
                night = Double(timingsSplit[3]) ?? 0.0
            }
            
        } else {
            wheneverNecessary = true
            morning = 0
            afternoon = 0
            night = 0
        }
        
        self.makeNewMedicine()
    }

    func clearValues () {
        medicineName = ""
        dosage = MakeEmptyDosage()
        duration = MakeEmptyDuration()
        intake = ""
        routeOfAdmin = ""
        frequency = ""
        notes = ""
        wheneverNecessary = false
    }
    
    func makeMedObjAndAdd() {
        medicineEditedDelegate?.addMedicine()
    }
    
    func autoSelectMedicine (medicine:ServiceProviderAutofillMedicine) {
        EndEditingHelper.endEditing()
        medicineName = medicine.BrandName
        routeOfAdmin = medicine.RouteOfAdministration

        medicineNameFinalized()
    }
    

    func makeNewMedicine () {
        EndEditingHelper.endEditing()
        medicineNameFinalized()
        self.isFirstResponder = false
    }
    
    func medicineNameFinalized() {
        self.medicineNameConfirmed = true
        self.medicineNameChanged = false
        self.showPredictedMedicines = false
    }
}

extension MedicineEntryViewModel {
    func changed() {
        self.showPredictedMedicines = true
        self.medicineNameChanged = true
        self.medicineNameConfirmed = false
    }
}

extension MedicineEntryViewModel : SideBySideCheckBoxDelegate {
    func itemChecked(value: String) {
        self.duration.Unit = value
    }
}
