//
//  MedicineViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 22/01/21.
//

import Foundation

class MedicineViewModel: ObservableObject {
    @Published var medicineArr:[Nambadoctor_V1_MedicineObject] = [Nambadoctor_V1_MedicineObject]()
    @Published var tempMedicine:Nambadoctor_V1_MedicineObject = Nambadoctor_V1_MedicineObject()
    @Published var medicineEntryVM:MedicineEntryViewModel = MedicineEntryViewModel()
    
    //global alert will not show when using bottom sheet
    @Published var showLocalAlert:Bool = false

    var generalDoctorHelpers:GeneralDoctorHelpersProtocol!
    
    init(generalDoctorHelpers:GeneralDoctorHelpersProtocol = GeneralDoctorHelpers()) {
        self.generalDoctorHelpers = generalDoctorHelpers
    }

    var medFoodCorrelation:String { return foodSelectionArray[medicineEntryVM.foodSelectionIndex] }
    var routeOfAdministration:String { return routeOfAdmissionArray[medicineEntryVM.routeOfAdminIndex] }
    var medInTake:String { return medicineInTakeTimings[medicineEntryVM.inTakeIndex] }
    
    var morningQuanityDisplay:String {
        return generalDoctorHelpers.convertingToFraction(decimal: Double(medicineEntryVM.morningTemp.clean)!)
    }
    var noonQuanityDisplay:String {
        return generalDoctorHelpers.convertingToFraction(decimal: Double(medicineEntryVM.noonTemp.clean)!)
    }
    var eveQuanityDisplay:String {
        return generalDoctorHelpers.convertingToFraction(decimal: Double(medicineEntryVM.eveningTemp.clean)!)
    }
    var nightQuanityDisplay:String {
        return generalDoctorHelpers.convertingToFraction(decimal: Double(medicineEntryVM.nightTemp.clean)!)
    }
    
    func timingStringForMedDisplay (medicine:Nambadoctor_V1_MedicineObject) -> String {
        return generalDoctorHelpers.formatTimingToDecimal(timings: medicine.timings)
    }

    func addMedicineOnTap () {
        EndEditingHelper.endEditing()
        tempMedicine = Nambadoctor_V1_MedicineObject()
        medicineEntryVM.isNewMedicine = true
        medicineEntryVM.showAddMedicineSheet.toggle()
    }

    func editMedicineOnTap (medicineToEdit:Nambadoctor_V1_MedicineObject) {
        tempMedicine = medicineToEdit
        medicineEntryVM.isNewMedicine = false
        medicineEntryVM.mapExistingMedicine(medicine: tempMedicine)
        medicineEntryVM.showAddMedicineSheet = true
    }

    func removePrescriptionRows(at offsets: IndexSet) {
        medicineArr.remove(atOffsets: offsets)
    }

    func dismissMedicineEntrySheet () {
        medicineEntryVM.clearValues()
        medicineEntryVM.showAddMedicineSheet = false
    }

    func finishWritingMedicine(isNewMedicine:Bool) {
        guard !medicineEntryVM.medicineName.isEmpty, !medicineEntryVM.dosage.isEmpty  else {
            GlobalPopupHelpers.fillAllFieldsAlert()
            self.showLocalAlert = true
            return
        }
        
        mapMedicineValuesToTemp()

        if isNewMedicine {
            medicineArr.append(tempMedicine)
        } else {
            let indexOfmed = generalDoctorHelpers.getMedicineIndex(medicineArr: medicineArr, medicine: tempMedicine)
            medicineArr[indexOfmed-1] = tempMedicine
        }
        
        dismissMedicineEntrySheet()
    }

    func mapMedicineValuesToTemp() {
        tempMedicine.medicineName = medicineEntryVM.medicineName
        tempMedicine.dosage = medicineEntryVM.dosage
        tempMedicine.timings = medicineEntryVM.timingString
        tempMedicine.specialInstructions = medFoodCorrelation
        tempMedicine.routeOfAdministration = routeOfAdministration
        tempMedicine.intake = medInTake

        if medicineEntryVM.noSpecificDuration {
            tempMedicine.duration = 0
        } else {
            tempMedicine.duration = Int32(generalDoctorHelpers.returnNoOfDaysWithIndex(numOfDays: medicineEntryVM.tempNumOfDays, timeIndex: medicineEntryVM.timeIndex))
        }
    }
}
