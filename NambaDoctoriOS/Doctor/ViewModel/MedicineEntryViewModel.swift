//
//  MedicineEntryViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 22/01/21.
//

import Foundation

class MedicineEntryViewModel : ObservableObject {
    var isNewMedicine:Bool = false
    @Published var showAddMedicineSheet:Bool = false

    @Published var medicineName:String = ""
    @Published var dosage:String = ""

    @Published var noSpecificDuration:Bool = false
    @Published var tempNumOfDays:String = ""
    @Published var timeIndex = 0

    @Published var inTakeIndex = 0
    @Published var routeOfAdminIndex = 0
    @Published var foodSelectionIndex = 0

    @Published var morningTemp = 0.0
    @Published var noonTemp = 0.0
    @Published var eveningTemp = 0.0
    @Published var nightTemp = 0.0

    var generalDoctorHelpers:GeneralDoctorHelpersProtocol
    
    init(generalDoctorHelpers:GeneralDoctorHelpersProtocol = GeneralDoctorHelpers()) {
        self.generalDoctorHelpers = generalDoctorHelpers
    }

    var timingString:String {
        let morning = morningTemp.clean
        let afternoon = noonTemp.clean
        let evening = eveningTemp.clean
        let night = nightTemp.clean
        return "\(morning),\(afternoon),\(evening),\(night)"
    }

    func mapExistingMedicine(medicine:Nambadoctor_V1_MedicineObject) {
        medicineName = medicine.medicineName
        dosage = medicine.dosage

        if medicine.duration == 0 {
            noSpecificDuration = true
        } else {
            tempNumOfDays = String(medicine.duration)
            timeIndex = 0
        }

        let timingDoubleArr = generalDoctorHelpers.splitTimingStringIntoDoubleArr(timings: medicine.timings)
        
        //TODO: CHANGE AFTER UNDERSTANDING THE TIMING STRUCTURE
        if timingDoubleArr.count > 1 {
            print()
            morningTemp = timingDoubleArr[0]
            noonTemp = timingDoubleArr[1]
            eveningTemp = timingDoubleArr[2]
            nightTemp = timingDoubleArr[3]
        }

        inTakeIndex = medicineInTakeTimings.firstIndex(of: medicine.intake) ?? 0
        routeOfAdminIndex = routeOfAdmissionArray.firstIndex(of: medicine.routeOfAdministration) ?? 0
        foodSelectionIndex = foodSelectionArray.firstIndex(of: medicine.specialInstructions) ?? 0
    }

    func clearValues () {
        medicineName = ""
        dosage = ""
        noSpecificDuration = false
        tempNumOfDays = ""
        timeIndex = 0
        inTakeIndex = 0
        foodSelectionIndex = 0
        routeOfAdminIndex = 0
        morningTemp = 0.0
        noonTemp = 0.0
        eveningTemp = 0.0
        nightTemp = 0.0
    }
}
