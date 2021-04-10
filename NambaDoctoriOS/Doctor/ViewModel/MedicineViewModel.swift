//
//  MedicineViewModel.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 22/01/21.
//

import Foundation

class MedicineViewModel: ObservableObject {
    var appointment:ServiceProviderAppointment
    @Published var prescription:ServiceProviderPrescription

    //global alert will not show when using bottom sheet
    @Published var showLocalAlert:Bool = false
    
    @Published var showMedicineEntrySheet:Bool = false
    @Published var medicineEntryVM:MedicineEntryViewModel!
    
    @Published var imagePickerVM:ImagePickerViewModel = ImagePickerViewModel()
    @Published var localImageSelected:Bool = false
    @Published var imageLoader:ImageLoader? = nil

    @Published var hasNoMedicineOrImage:Bool = false

    var medicineBeingEdited:Int? = nil
    
    var generalDoctorHelpers:GeneralDoctorHelpersProtocol!
    private var retrievePrescriptionHelper:PrescriptionGetSetServiceCallProtocol
    var prescriptionServiceCalls:PrescriptionGetSetServiceCallProtocol
    
    init(appointment:ServiceProviderAppointment,
         generalDoctorHelpers:GeneralDoctorHelpersProtocol = GeneralDoctorHelpers(),
         retrievePrescriptionHelper:PrescriptionGetSetServiceCallProtocol = PrescriptionGetSetServiceCall(),
         prescriptionServiceCalls:PrescriptionGetSetServiceCallProtocol = PrescriptionGetSetServiceCall()) {
        
        self.appointment = appointment
        self.generalDoctorHelpers = generalDoctorHelpers
        self.retrievePrescriptionHelper = retrievePrescriptionHelper
        self.prescriptionServiceCalls = prescriptionServiceCalls
        self.prescription = MakeEmptyPrescription(appointment: appointment)

        self.imagePickerVM.imagePickerDelegate = self
        
        self.medicineEntryVM = MedicineEntryViewModel(medicine: MakeEmptyMedicine(), isNew: true, medicineEditedDelegate: self)
        self.medicineEntryVM.medicineEditedDelegate = self
        
        self.retrievePrescriptions()
    }

    func uploadManually() {
        self.medicineEntryVM = MedicineEntryViewModel(medicine: MakeEmptyMedicine(), isNew: true, medicineEditedDelegate: self)
        self.showMedicineEntrySheet = true
    }
    
    func editPrescription (medicine:ServiceProviderMedicine) {
        medicineBeingEdited = checkIfPrescriptionExists(medicine: medicine)
        self.medicineEntryVM = MedicineEntryViewModel(medicine: medicine, isNew: false, medicineEditedDelegate: self)
        self.showMedicineEntrySheet = true
    }
    
    func removePrescription (medicine:ServiceProviderMedicine) {
        if let index = checkIfPrescriptionExists(medicine: medicine) {
            prescription.medicineList.remove(at: index)
        }
    }
    
    func checkIfPrescriptionExists (medicine:ServiceProviderMedicine) -> Int? {
        var index = 0
        for med in prescription.medicineList {
            if med.medicineName == medicine.medicineName && med.dosage == medicine.dosage {
                return index
            }
            index += 1
        }
        return nil
    }

    func makeMedicineObjAndAdd () {
        let medicine = ServiceProviderMedicine(medicineName: medicineEntryVM.medicineName, dosage: medicineEntryVM.dosage, routeOfAdministration: medicineEntryVM.routeOfAdmin, intake: medicineEntryVM.intake, duration: 0, timings: "", specialInstructions: medicineEntryVM.frequency, medicineID: "")

        if medicineBeingEdited != nil {
            prescription.medicineList.remove(at: medicineBeingEdited!)
            prescription.medicineList.insert(medicine, at: medicineBeingEdited!)
            showMedicineEntrySheet = false
        } else {
            prescription.medicineList.append(medicine)
            showMedicineEntrySheet = false
        }
        
        self.medicineEntryVM.clearValues()
    }
    
    
    func retrievePrescriptions () {
        retrievePrescriptionHelper.getPrescription(appointmentId: self.appointment.appointmentID, serviceRequestId: self.appointment.serviceRequestID, customerId: self.appointment.customerID) { (prescription) in
            if prescription != nil {
                self.prescription = prescription!
                //need to optimize in service side
                self.prescription.customerID = self.appointment.customerID
                self.prescription.serviceRequestID = self.appointment.serviceRequestID
                self.downloadPrescription()
                //end
            } else {
                self.prescription = MakeEmptyPrescription(appointment: self.appointment)
            }
            CommonDefaultModifiers.hideLoader()
        }
    }

    func downloadPrescription () {
        hasNoMedicineOrImage = false

        func ifmedListAlsoEmptyCheck () {
            if self.prescription.medicineList.isEmpty {
                self.hasNoMedicineOrImage = true
            }
        }
        
        retrievePrescriptionHelper.downloadPrescription(prescriptionID: prescription.prescriptionID) { (imageDataURL) in
            if imageDataURL != nil {
                self.imageLoader = ImageLoader(urlString: imageDataURL!) { success in
                    if !success {
                        self.imageLoader = nil
                        ifmedListAlsoEmptyCheck()
                    }
                }
            } else {
                ifmedListAlsoEmptyCheck()
            }
        }
    }

    func sendToPatient (completion: @escaping (_ success:Bool)->()) {
        prescription.prescriptionID = "" //service will make new prescription ID to update not overwrite
        
        if imagePickerVM.image != nil {
            self.prescription.fileInfo.FileName = ""
            self.prescription.fileInfo.FileType = "png"
            self.prescription.fileInfo.MediaImage = imagePickerVM.image!.jpegData(compressionQuality: 0.3)!.base64EncodedString()
        }
        
        if imageLoader != nil {
            self.prescription.fileInfo.MediaImage = imageLoader!.image!.jpegData(compressionQuality: 0.3)!.base64EncodedString()
        }

        self.prescription.createdDateTime = Date().millisecondsSince1970
        prescriptionServiceCalls.setPrescription(prescription: self.prescription) { (response) in
            self.imageLoader = nil
            //self.imagePickerVM = nil
            completion(response)
        }
    }
}

extension MedicineViewModel : MedicineEntryDelegate {
    func addMedicine() {
        self.makeMedicineObjAndAdd()
    }
}

extension MedicineViewModel : ImagePickedDelegate {
    func imageSelected() {
        self.imageLoader = nil
        self.localImageSelected = true
    }

    func removeSelectImage () {
        self.imagePickerVM.image = nil
        self.localImageSelected = false
    }

    func removeLoadedImage () {
        self.imageLoader = nil
    }
}
