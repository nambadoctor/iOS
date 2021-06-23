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
    @Published var showRemoveButton:Bool = false
    @Published var imageLoader:ImageLoader? = nil

    @Published var hasNoMedicineOrImage:Bool = false
    
    @Published var autoFillVM:AutoFillMedicineVM = AutoFillMedicineVM()

    @Published var prescriptionPDF:Data? = nil
    var medicineBeingEdited:Int? = nil

    var generalDoctorHelpers:GeneralDoctorHelpersProtocol!
    private var retrievePrescriptionHelper:ServiceProviderPrescriptionServiceProtocol
    var prescriptionServiceCalls:ServiceProviderPrescriptionServiceProtocol
    
    init(appointment:ServiceProviderAppointment,
         generalDoctorHelpers:GeneralDoctorHelpersProtocol = GeneralDoctorHelpers(),
         retrievePrescriptionHelper:ServiceProviderPrescriptionServiceProtocol = ServiceProviderPrescriptionService(),
         prescriptionServiceCalls:ServiceProviderPrescriptionServiceProtocol = ServiceProviderPrescriptionService()) {
        
        self.appointment = appointment
        self.generalDoctorHelpers = generalDoctorHelpers
        self.retrievePrescriptionHelper = retrievePrescriptionHelper
        self.prescriptionServiceCalls = prescriptionServiceCalls
        self.prescription = MakeEmptyPrescription(appointment: appointment)

        self.imagePickerVM.imagePickerDelegate = self
        
        self.medicineEntryVM = MedicineEntryViewModel(medicine: MakeEmptyMedicine(), isNew: true, medicineEditedDelegate: self, autoFillVM: self.autoFillVM)
        self.medicineEntryVM.medicineEditedDelegate = self
        
        self.retrievePrescriptions()
    }
    
    func uploadManually() {
        self.medicineEntryVM = MedicineEntryViewModel(medicine: MakeEmptyMedicine(), isNew: true, medicineEditedDelegate: self, autoFillVM: self.autoFillVM)
        self.showMedicineEntrySheet = true
    }

    func editPrescription (medicine:ServiceProviderMedicine) {
        medicineBeingEdited = checkIfPrescriptionExists(medicine: medicine)
        self.medicineEntryVM = MedicineEntryViewModel(medicine: medicine, isNew: false, medicineEditedDelegate: self, autoFillVM: self.autoFillVM)
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
            if med.medicineName == medicine.medicineName {
                return index
            }
            index += 1
        }
        return nil
    }

    func makeMedicineObjAndAdd () {
        var timingsString = "\(medicineEntryVM.morning.clean),\(medicineEntryVM.afternoon.clean),\(medicineEntryVM.night.clean)"

        if medicineEntryVM.wheneverNecessary || timingsString == "0,0,0" {
            timingsString = ""
        }

        let medicine = ServiceProviderMedicine(medicineName: medicineEntryVM.medicineName, intakeDosage: medicineEntryVM.dosage, routeOfAdministration: medicineEntryVM.routeOfAdmin, intake: medicineEntryVM.intake, _duration: medicineEntryVM.duration, timings: timingsString, specialInstructions: medicineEntryVM.frequency, medicineID: UUID().uuidString, notes: medicineEntryVM.notes)

        if medicineBeingEdited != nil && !prescription.medicineList.isEmpty {
            prescription.medicineList.remove(at: medicineBeingEdited!)
            prescription.medicineList.insert(medicine, at: medicineBeingEdited!)
            showMedicineEntrySheet = false
        } else {
            prescription.medicineList.append(medicine)
            showMedicineEntrySheet = false 
        }

        self.medicineEntryVM.clearValues()
        self.medicineBeingEdited = nil
    }
    
    
    func retrievePrescriptions () {
        retrievePrescriptionHelper.getPrescription(appointmentId: self.appointment.appointmentID, serviceRequestId: self.appointment.serviceRequestID, customerId: self.appointment.customerID) { (prescription) in
            if prescription != nil {
                self.prescription = prescription!
                //need to optimize in service side
                self.prescription.customerID = self.appointment.customerID
                self.prescription.serviceRequestID = self.appointment.serviceRequestID
                self.downloadPrescription()
                
                if !self.prescription.medicineList.isEmpty {
                    self.getPrescriptionPDF()
                }
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
        
        if self.prescription.fileInfo.FileType.toPlain == "png" {
            retrievePrescriptionHelper.downloadPrescription(prescriptionID: prescription.prescriptionID) { (imageDataURL) in
                if imageDataURL != nil {
                    self.imageLoader = ImageLoader(urlString: imageDataURL!) { success in
                        if !success {
                            self.imageLoader = nil
                            ifmedListAlsoEmptyCheck()
                            self.showRemoveButton = false
                        } else {
                            self.showRemoveButton = true
                        }
                    }
                } else {
                    ifmedListAlsoEmptyCheck()
                }
            }
        } else {
            self.imageLoader = nil
            ifmedListAlsoEmptyCheck()
            self.showRemoveButton = false
        }
    }
    
    func getPrescriptionPDF () {
        LoggerService().log(eventName: "Getting PDF from service")
        self.prescriptionPDF = nil
        retrievePrescriptionHelper.getPrescriptionPDF(customerId: appointment.customerID, serviceProviderId: appointment.serviceProviderID, appointmentId: appointment.appointmentID, serviceRequestId: appointment.serviceRequestID) { data in
            if data != nil {
                CommonDefaultModifiers.hideLoader()
                self.prescriptionPDF = data!
                print("PDF IS SET: \(self.prescriptionPDF)")
            }
        }
    }

    func storeImageValues () {
        if imagePickerVM.image != nil {
            self.prescription.fileInfo.FileName = ""
            self.prescription.fileInfo.FileType = "png"
            self.prescription.fileInfo.MediaImage = imagePickerVM.image!.jpegData(compressionQuality: 0.3)!.base64EncodedString()
        }

        if imageLoader?.image != nil {
            self.prescription.fileInfo.MediaImage = imageLoader?.image?.jpegData(compressionQuality: 0.3)!.base64EncodedString() ?? ""
            self.prescription.fileInfo.FileType = "png"
        }
        
        if imageLoader?.image == nil && imagePickerVM.image == nil {
            self.prescription.fileInfo.FileName = ""
            self.prescription.fileInfo.FileType = ""
            self.prescription.fileInfo.MediaImage = ""
        }
    }

    func sendToPatient (completion: @escaping (_ success:Bool)->()) {
        prescription.prescriptionID = "" //service will make new prescription ID to update not overwrite

        storeImageValues()

        for index in 0..<prescription.medicineList.count {
            prescription.medicineList[index].medicineID = ""
        }
        
        self.prescription.createdDateTime = Date().millisecondsSince1970
        prescriptionServiceCalls.setPrescription(prescription: self.prescription) { (response) in
            self.imageLoader = nil
            self.retrievePrescriptions() //to make sure each medicine has ID if being edited again...
            completion(response)
        }
    }

    func saveCurrentChanges () {
        storeImageValues()
    }
    
//
//    func checkForNewMedicines () {
//        var newMedicines:[ServiceProviderMedicine] = [ServiceProviderMedicine]()
//
//        for index in 0..<self.prescription.medicineList.count {
//            if !self.autoFillVM.autofillMedicineList.contains { $0.BrandName.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) == self.prescription.medicineList[index].medicineName.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) } {
//                print("NEW MED: \(self.prescription.medicineList[index])")
//                newMedicines.append(self.prescription.medicineList[index])
//            }
//        }
//
//        if newMedicines.count > 0 {
//            ServiceProviderProfileService().setNewMedicineList(medicines: newMedicines) { _ in }
//        }
//    }
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
        self.showRemoveButton = true
    }

    func removeSelectImage () {
        self.imagePickerVM.image = nil
        self.localImageSelected = false
        self.showRemoveButton = false
    }

    func removeLoadedImage () {
        self.imageLoader = nil
        self.showRemoveButton = false
    }
}
