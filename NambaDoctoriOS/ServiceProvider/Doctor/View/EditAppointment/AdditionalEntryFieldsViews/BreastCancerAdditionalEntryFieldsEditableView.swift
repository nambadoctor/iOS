//
//  AdditionalEntryFieldsEditableView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 8/24/21.
//

import SwiftUI

struct BreastCancerAdditionalEntryFieldsEditableView: View {
    @EnvironmentObject var serviceRequestVM:ServiceRequestViewModel
    @EnvironmentObject var configurableEntryVM:DoctorConfigurableEntryFieldsViewModel
    
    var body: some View {
        VStack (alignment: .leading) {
            Group {
                if configurableEntryVM.selectedEntryField.Menarche {
                    Group {
                        HStack (spacing: 3) {
                            Image("eyeglasses")
                                .modifier(DetailedAppointmentViewIconModifier())
                            
                            Text("MENARCHE")
                                .font(.footnote)
                                .foregroundColor(Color.black.opacity(0.4))
                                .bold()
                        }
                        ExpandingTextEntryView(text: self.$serviceRequestVM.serviceRequest.additionalEntryFields.Menarche)
                    }
                }

                if configurableEntryVM.selectedEntryField.Periods {
                    Group {
                        HStack (spacing: 3) {
                            Image("eyeglasses")
                                .modifier(DetailedAppointmentViewIconModifier())
                            
                            Text("PERIODS")
                                .font(.footnote)
                                .foregroundColor(Color.black.opacity(0.4))
                                .bold()
                        }
                        ExpandingTextEntryView(text: self.$serviceRequestVM.serviceRequest.additionalEntryFields.Periods)
                    }
                }
                
                if configurableEntryVM.selectedEntryField.AgeAtFirstChildBirth {
                    Group {
                        HStack (spacing: 3) {
                            Image("eyeglasses")
                                .modifier(DetailedAppointmentViewIconModifier())
                            
                            Text("AGE AT FIRST CHILD BIRTH")
                                .font(.footnote)
                                .foregroundColor(Color.black.opacity(0.4))
                                .bold()
                        }
                        
                        ExpandingTextEntryView(text: self.$serviceRequestVM.serviceRequest.additionalEntryFields.AgeAtFirstChildBirth, keyboardType: .numberPad)
                    }
                }
                
                if configurableEntryVM.selectedEntryField.LMP {
                    Group {
                        HStack (spacing: 3) {
                            Image("eyeglasses")
                                .modifier(DetailedAppointmentViewIconModifier())
                            
                            Text("LMP")
                                .font(.footnote)
                                .foregroundColor(Color.black.opacity(0.4))
                                .bold()
                        }
                        
                        ExpandingTextEntryView(text: self.$serviceRequestVM.serviceRequest.additionalEntryFields.LMP, keyboardType: .numberPad)
                    }
                }
                
                if configurableEntryVM.selectedEntryField.NoOfChildren {
                    Group {
                        HStack (spacing: 3) {
                            Image("eyeglasses")
                                .modifier(DetailedAppointmentViewIconModifier())
                            
                            Text("NUMBER OF CHILDREN")
                                .font(.footnote)
                                .foregroundColor(Color.black.opacity(0.4))
                                .bold()
                        }
                        ExpandingTextEntryView(text: self.$serviceRequestVM.serviceRequest.additionalEntryFields.NoOfChildren)
                    }
                }
                
                if configurableEntryVM.selectedEntryField.BreastFeeding {
                    Group {
                        HStack (spacing: 3) {
                            Image("eyeglasses")
                                .modifier(DetailedAppointmentViewIconModifier())
                            
                            Text("BREAST FEEDING")
                                .font(.footnote)
                                .foregroundColor(Color.black.opacity(0.4))
                                .bold()
                        }
                        ExpandingTextEntryView(text: self.$serviceRequestVM.serviceRequest.additionalEntryFields.BreastFeeding)
                    }
                }
                
                if configurableEntryVM.selectedEntryField.FamilyHistoryOfCancer {
                    Group {
                        HStack (spacing: 3) {
                            Image("eyeglasses")
                                .modifier(DetailedAppointmentViewIconModifier())
                            
                            Text("FAMILY HISTORY OF CANCER")
                                .font(.footnote)
                                .foregroundColor(Color.black.opacity(0.4))
                                .bold()
                        }
                        ExpandingTextEntryView(text: self.$serviceRequestVM.serviceRequest.additionalEntryFields.FamilyHistoryOfCancer)
                    }
                }
                
                if configurableEntryVM.selectedEntryField.OtherCancers {
                    Group {
                        HStack (spacing: 3) {
                            Image("eyeglasses")
                                .modifier(DetailedAppointmentViewIconModifier())
                            
                            Text("OTHER CANCERS")
                                .font(.footnote)
                                .foregroundColor(Color.black.opacity(0.4))
                                .bold()
                        }
                        ExpandingTextEntryView(text: self.$serviceRequestVM.serviceRequest.additionalEntryFields.OtherCancers)
                    }
                }
                
                if configurableEntryVM.selectedEntryField.Diabetes {
                    Group {
                        HStack (spacing: 3) {
                            Image("eyeglasses")
                                .modifier(DetailedAppointmentViewIconModifier())

                            Text("DIABETED")
                                .font(.footnote)
                                .foregroundColor(Color.black.opacity(0.4))
                                .bold()
                        }
                        ExpandingTextEntryView(text: self.$serviceRequestVM.serviceRequest.additionalEntryFields.Diabetes)
                    }
                }

                if configurableEntryVM.selectedEntryField.Hypertension {
                    Group {
                        HStack (spacing: 3) {
                            Image("eyeglasses")
                                .modifier(DetailedAppointmentViewIconModifier())

                            Text("HYPERTENSION")
                                .font(.footnote)
                                .foregroundColor(Color.black.opacity(0.4))
                                .bold()
                        }
                        ExpandingTextEntryView(text: self.$serviceRequestVM.serviceRequest.additionalEntryFields.Hypertension)
                    }
                }

            }
            
            if configurableEntryVM.selectedEntryField.Asthma {
                Group {
                    HStack (spacing: 3) {
                        Image("eyeglasses")
                            .modifier(DetailedAppointmentViewIconModifier())

                        Text("ASTHMA")
                            .font(.footnote)
                            .foregroundColor(Color.black.opacity(0.4))
                            .bold()
                    }
                    ExpandingTextEntryView(text: self.$serviceRequestVM.serviceRequest.additionalEntryFields.Asthma)
                }
            }

            if configurableEntryVM.selectedEntryField.Thyroid {
                Group {
                    HStack (spacing: 3) {
                        Image("eyeglasses")
                            .modifier(DetailedAppointmentViewIconModifier())

                        Text("THYROID")
                            .font(.footnote)
                            .foregroundColor(Color.black.opacity(0.4))
                            .bold()
                    }
                    ExpandingTextEntryView(text: self.$serviceRequestVM.serviceRequest.additionalEntryFields.Thyroid)
                }
            }

            
            if configurableEntryVM.selectedEntryField.Medication {
                Group {
                    HStack (spacing: 3) {
                        Image("eyeglasses")
                            .modifier(DetailedAppointmentViewIconModifier())

                        Text("MEDICATION")
                            .font(.footnote)
                            .foregroundColor(Color.black.opacity(0.4))
                            .bold()
                    }
                    ExpandingTextEntryView(text: self.$serviceRequestVM.serviceRequest.additionalEntryFields.Medication)
                }
            }

            
            if configurableEntryVM.selectedEntryField.DietAndAppetite {
                Group {
                    HStack (spacing: 3) {
                        Image("eyeglasses")
                            .modifier(DetailedAppointmentViewIconModifier())

                        Text("DIET AND APPETITE")
                            .font(.footnote)
                            .foregroundColor(Color.black.opacity(0.4))
                            .bold()
                    }
                    ExpandingTextEntryView(text: self.$serviceRequestVM.serviceRequest.additionalEntryFields.DietAndAppetite)
                }
            }
            
            if configurableEntryVM.selectedEntryField.Habits {
                Group {
                    HStack (spacing: 3) {
                        Image("eyeglasses")
                            .modifier(DetailedAppointmentViewIconModifier())

                        Text("HABITS")
                            .font(.footnote)
                            .foregroundColor(Color.black.opacity(0.4))
                            .bold()
                    }
                    ExpandingTextEntryView(text: self.$serviceRequestVM.serviceRequest.additionalEntryFields.Habits)
                }
            }
            
            if configurableEntryVM.selectedEntryField.BreastExamination {
                Group {
                    HStack (spacing: 3) {
                        Image("eyeglasses")
                            .modifier(DetailedAppointmentViewIconModifier())

                        Text("BREAST EXAMINATION")
                            .font(.footnote)
                            .foregroundColor(Color.black.opacity(0.4))
                            .bold()
                    }
                    ExpandingTextEntryView(text: self.$serviceRequestVM.serviceRequest.additionalEntryFields.BreastExamination)
                }
            }

        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .padding(.horizontal)
    }
}
