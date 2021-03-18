//
//  MedicineViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 22/01/21.
//

import Foundation

class MedicineViewModel: ObservableObject {
    var appointment:ServiceProviderAppointment
    @Published var prescription:ServiceProviderPrescription?
    @Published var tempMedicine:ServiceProviderMedicine = MakeEmptyMedicine()
    @Published var medicineEntryVM:MedicineEntryViewModel = MedicineEntryViewModel()
    
    //global alert will not show when using bottom sheet
    @Published var showLocalAlert:Bool = false

    var generalDoctorHelpers:GeneralDoctorHelpersProtocol!
    private var retrieveMedicineHelper:RetrievePrescriptionForAppointmentProtocol
    
    init(appointment:ServiceProviderAppointment,
        generalDoctorHelpers:GeneralDoctorHelpersProtocol = GeneralDoctorHelpers(),
         retrieveMedicineHelper:RetrievePrescriptionForAppointmentProtocol = RetrievePrescriptionForAppointmentViewModel()) {
        self.appointment = appointment
        self.generalDoctorHelpers = generalDoctorHelpers
        self.retrieveMedicineHelper = retrieveMedicineHelper
        
        DispatchQueue.main.async {
            self.retrieveMedicines()
        }
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
    
    func retrieveMedicines () {
        retrieveMedicineHelper.getPrescription(appointmentId: self.appointment.appointmentID, serviceRequestId: self.appointment.serviceRequestID, customerId: self.appointment.customerID) { (prescription) in
            if prescription != nil {
                self.prescription = prescription!
            }
        }
    }
    
    func timingStringForMedDisplay (medicine:ServiceProviderMedicine) -> String {
        return generalDoctorHelpers.formatTimingToDecimal(timings: medicine.timings)
    }

    func addMedicineOnTap () {
        EndEditingHelper.endEditing()
        tempMedicine = MakeEmptyMedicine()
        medicineEntryVM.isNewMedicine = true
        medicineEntryVM.showAddMedicineSheet.toggle()
    }

    func editMedicineOnTap (medicineToEdit:ServiceProviderMedicine) {
        tempMedicine = medicineToEdit
        medicineEntryVM.isNewMedicine = false
        medicineEntryVM.mapExistingMedicine(medicine: tempMedicine)
        medicineEntryVM.showAddMedicineSheet = true
    }
    
    func removeMedicineManually (medicine:ServiceProviderMedicine) {
        let index = generalDoctorHelpers.getMedicineIndex(medicineArr: prescription!.medicineList, medicine: medicine)
        prescription!.medicineList.remove(at: index)
    }

    func removeMedicineRowsBySwiping(at offsets: IndexSet) {
        prescription!.medicineList.remove(atOffsets: offsets)
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
            prescription!.medicineList.append(tempMedicine)
        } else {
            let indexOfmed = generalDoctorHelpers.getMedicineIndex(medicineArr: prescription!.medicineList, medicine: tempMedicine)
            prescription!.medicineList[indexOfmed == 0 ? indexOfmed : indexOfmed-1] = tempMedicine
        }
        
        tempMedicine = MakeEmptyMedicine()
        
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
