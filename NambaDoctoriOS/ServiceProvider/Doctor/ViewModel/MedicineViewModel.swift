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
    
    @Published var imagePickerVM:MultipleImagePickerViewModel = MultipleImagePickerViewModel()
    @Published var localImageSelected:Bool = false
    @Published var showRemoveButton:Bool = false
    @Published var imageLoader:ImageLoader? = nil
    @Published var imageLoaders:[ImageLoader]? = nil

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
                        }
                    }
                } else {
                    ifmedListAlsoEmptyCheck()
                }
            }
        } else if !self.prescription.uploadedPrescriptionDocuments.isEmpty {
            self.imageLoaders = [ImageLoader]()
            for uploadedDoc in self.prescription.uploadedPrescriptionDocuments {
                retrievePrescriptionHelper.downloadPrescription(prescriptionID: uploadedDoc.FileInfoId) { (imageDataURL) in
                    if imageDataURL != nil {
                        self.imageLoaders?.append(ImageLoader(urlString: imageDataURL!) { _ in})
                    }
                }
            }
        } else {
            self.imageLoader = nil
            ifmedListAlsoEmptyCheck()
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
        
        self.prescription.uploadedPrescriptionDocuments.removeAll()
        
        if imagePickerVM.images != nil {
            for eachImage in imagePickerVM.images! {
                let fileInfo = ServiceProviderFileInfo(FileName: "", FileType: "png", MediaImage: eachImage.jpegData(compressionQuality: 0.3)!.base64EncodedString(), FileInfoId: "")
                
                self.prescription.uploadedPrescriptionDocuments.append(fileInfo)
            }
        }

        if imageLoaders != nil {
            for loader in self.imageLoaders! {
                let fileInfo = ServiceProviderFileInfo(FileName: "", FileType: "png", MediaImage: loader.image?.jpegData(compressionQuality: 0.3)!.base64EncodedString() ?? "", FileInfoId: "")
                self.prescription.uploadedPrescriptionDocuments.append(fileInfo)
            }
        }
        
        if imageLoaders == nil && imagePickerVM.images == nil {
            self.prescription.uploadedPrescriptionDocuments = [ServiceProviderFileInfo]()
        }
    }
    
    func clearMedicineIds () {
        for index in 0..<prescription.medicineList.count {
            prescription.medicineList[index].medicineID = ""
        }
    }

    func sendToPatient (completion: @escaping (_ success:Bool)->()) {
        prescription.prescriptionID = "" //service will make new prescription ID to update not overwrite

        storeImageValues()

        clearMedicineIds()
        
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
    
    func removeImage (imageToRemove:ImageLoader) {
        var index = 0
        for loader in imageLoaders! {
            if loader.id == imageToRemove.id {
                self.imageLoaders!.remove(at: index)
                break
            }
            index += 1
        }
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
