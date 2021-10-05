//
//  CreatedTemplatesView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 9/22/21.
//

import SwiftUI

class CreatedTemplateViewModel : ObservableObject {
    @Published var createdTemplates:[ServiceProviderCustomCreatedTemplate] = [ServiceProviderCustomCreatedTemplate]()

    @Published var template:ServiceProviderCustomCreatedTemplate = ServiceProviderCustomCreatedTemplate(templateId: "", templateName: "", serviceProviderID: "", diagnosis: ServiceProviderDiagnosis(name: "", type: ""), investigations: [String](), advice: "", createdDateTime: Date().millisecondsSince1970, lastModifiedDate: Date().millisecondsSince1970, medicines: [ServiceProviderMedicine]())
    
    @Published var medicineVM:MedicineViewModel
    
    @Published var selectedTemplate:ServiceProviderCustomCreatedTemplate? = nil
    @Published var tempInvestigation:String = ""
    
    init(){
        self.medicineVM = MedicineViewModel(appointment: ServiceProviderAppointment(appointmentID: "", serviceRequestID: "", parentAppointmentID: "", customerID: "", serviceProviderID: "", requestedBy: "", serviceProviderName: "", customerName: "", isBlockedByServiceProvider: false, status: "", serviceFee: 0, followUpDays: 0, isPaid: false, scheduledAppointmentStartTime: 0, scheduledAppointmentEndTime: 0, actualAppointmentStartTime: 0, actualAppointmentEndTime: 0, createdDateTime: 0, lastModifiedDate: 0, noOfReports: 0, cancellation: nil, childId: "", paymentType: "", appointmentVerification: nil, organisationId: "", organisationName: "", IsInPersonAppointment: false, AddressId: "", AppointmentTransfer: nil))
        getTemplates()
    }
    
    func addInvestigation () {
        template.investigations.append(tempInvestigation)
        tempInvestigation = ""
    }
    
    func saveAsNewTemplate (){
        CommonDefaultModifiers.showLoader(incomingLoadingText: "Creating Template")
        self.medicineVM.clearMedicineIds()
        self.template.medicines = self.medicineVM.prescription.medicineList
        self.template.serviceProviderID = UserIdHelper().retrieveUserId()
        ServiceProviderProfileService().setCustomTemplateList(serviceProviderId: UserIdHelper().retrieveUserId(), template: template) { success in
            if success {
                DoctorAlertHelpers().templateSavedSuccessfullyAlert { _ in }
                
                self.getTemplates()
                self.template = ServiceProviderCustomCreatedTemplate(templateId: "", templateName: "", serviceProviderID: "", diagnosis: ServiceProviderDiagnosis(name: "", type: ""), investigations: [String](), advice: "", createdDateTime: Date().millisecondsSince1970, lastModifiedDate: Date().millisecondsSince1970, medicines: [ServiceProviderMedicine]())
                
            }
            CommonDefaultModifiers.hideLoader()
        }
    }
    
    func getTemplates () {
        ServiceProviderProfileService().getCustomTemplatesList(serviceProviderId: UserIdHelper().retrieveUserId()) { templates in
            if templates != nil {
                self.createdTemplates = templates!
            }
        }
    }
}

struct CreatedTemplatesView: View {
    @ObservedObject var createdTemplateVM:CreatedTemplateViewModel

    var body: some View {
        Form {
            
            TextField("Template Name", text: self.$createdTemplateVM.template.templateName)
            TextField("Advice", text: self.$createdTemplateVM.template.advice)
            TextField("Diagnosis", text: self.$createdTemplateVM.template.diagnosis.name)

            Section(header: Text("Investigations")) {
                ForEach(self.createdTemplateVM.template.investigations, id: \.self) { investigation in
                    Text(investigation)
                }
                
                Button {
                    self.createdTemplateVM.addInvestigation()
                } label: {
                    HStack {
                        TextField("Investigation Name", text: self.$createdTemplateVM.tempInvestigation)
                        Text("Add")
                    }
                }

            }
            
            Section(header: Text("Medicines")) {
                MedicineDisplay(medicineVM: self.createdTemplateVM.medicineVM, isEditable: true)
                AddMedicineButton(medicineVM: self.createdTemplateVM.medicineVM)
            }
                        
            Button {
                self.createdTemplateVM.saveAsNewTemplate()
            } label: {
                Text("Confirm")
            }
        }
    }
}
