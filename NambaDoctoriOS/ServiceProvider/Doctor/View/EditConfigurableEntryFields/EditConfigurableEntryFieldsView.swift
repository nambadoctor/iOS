//
//  EditConfigurableEntryFieldsView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 8/24/21.
//

import SwiftUI

struct EditConfigurableEntryFieldsView: View {
    @ObservedObject var configurableEntryVM:DoctorConfigurableEntryFieldsViewModel
    @Binding var showSheet:Bool
    
    var body: some View {
        NavigationView {
            Form {
                ForEach(self.configurableEntryVM.entryFieldsList, id: \.configurationName) { config in
                    Button(action: {
                        self.configurableEntryVM.confirmSettings (configuration: config) { success in
                            if success {
                                self.showSheet = false
                            }
                        }
                        self.showSheet = false
                    }, label: {
                        Text("\(config.configurationName)")
                    })
                }
            }
            .navigationBarTitle(Text("Select Configuration"), displayMode: .inline)
        }
    }
}
