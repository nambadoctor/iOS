//
//  WritePrescription.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 22/01/21.
//

import SwiftUI

struct WritePrescriptionView: View {
    
    @State private var tabNavigationIndex = 0
    @ObservedObject private var prescriptionVM:PrescriptionViewModel
    @Environment(\.presentationMode) var presentationMode
    
    init(appointment:Appointment,
         isNewPrescription:Bool) {
        prescriptionVM = PrescriptionViewModel(appointment: appointment, isNewPrescription: isNewPrescription)
    }

    var body: some View {
        VStack {
            if prescriptionVM.prescription == nil {
                Indicator()
            } else {
                tabbedHeaders
                Form {
                    if tabNavigationIndex == 0 {
                        BasicDetailsEntryView(prescriptionVM: prescriptionVM)
                    } else if tabNavigationIndex == 1 {
                        InvestigationsView(investigationsVM: prescriptionVM.InvestigationsVM)
                        
                        Section(header: Text("Patient Allergies: ")) { TextField("loading...", text: $prescriptionVM.patientAllergies) }
                        
                        Section(header: Text("Prescriptions (if any)")) {
                            MedicineView(medicineVM: prescriptionVM.MedicineVM)
                            
                            AddMedicine(medicineVM: prescriptionVM.MedicineVM)
                        }
                    } else if tabNavigationIndex == 2 {
                        
                        Section(header: Text("Advise for patient: ")) {
                            TextEditor(text: $prescriptionVM.prescription.additionalNotes)
                                .frame(width: UIScreen.main.bounds.width-60, height: 100) }
                        
                        MakeFollowUpAppointmentView(followUpAppointmentVM: prescriptionVM.FollowUpVM)
                        
                        reviewAndSubmitView
                    }
                }
                
                NavigationLink("",
                               destination: ReviewPrescriptionView(prescriptionVM: prescriptionVM),
                               isActive: $prescriptionVM.navigateToReviewPrescription)
                
                //FIND BETTER WAY TO DISMISS VIEWS WHEN WRITING PRESCRIPTION IS DONE!
                if prescriptionVM.dismissAllViews {
                    Text("").onAppear() {self.presentationMode.wrappedValue.dismiss()}
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: navBarLeadingBtn, trailing: navBarTrailingBtn)
    }
    
    private var navBarLeadingBtn : some View {
        Button(action: {
            prescriptionVM.navBarBackPressed { GoBack in
                self.presentationMode.wrappedValue.dismiss()
            }
        }, label: {
            Text("< Back")
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
        })
    }
    
    private var navBarTrailingBtn : some View {
        Text("Patient Info").onTapGesture() {prescriptionVM.viewPatientInfo()}
    }
    
    private var tabbedHeaders : some View {
        HStack (alignment: .bottom) {
            Spacer()
            VStack {
                Text("Clinical Details").frame(height: 50).foregroundColor(self.tabNavigationIndex == 0 ? Color.green : Color.black)
                Divider().frame(height: 2).background(self.tabNavigationIndex == 0 ? Color.green : Color.black)
            }.onTapGesture {
                self.tabNavigationIndex = 0
            }
            Spacer()
            VStack {
                Text("Medicine & Plan").frame(height: 50).foregroundColor(self.tabNavigationIndex == 1 ? Color.green : Color.black)
                Divider().frame(height: 2).background(self.tabNavigationIndex == 1 ? Color.green : Color.black)
            }.onTapGesture {
                self.tabNavigationIndex = 1
            }
            Spacer()
            VStack {
                Text("Optional").frame(height: 50).foregroundColor(self.tabNavigationIndex == 2 ? Color.green : Color.black)
                Divider().frame(height: 2).background(self.tabNavigationIndex == 2 ? Color.green : Color.black)
            }.onTapGesture {
                self.tabNavigationIndex = 2
            }
        }
    }
    
    private var reviewAndSubmitView : some View {
        HStack {
            Spacer()
            Text("Review and Submit").foregroundColor(Color.white)
            Spacer()
        }.padding(12)
        .background(Color(UIColor.blue))
        .cornerRadius(4)
        .onTapGesture {
            prescriptionVM.sendToReviewPrescription()
        }
    }
}
