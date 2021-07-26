//
//  ServiceProviderReportsEntryView.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 7/25/21.
//

import SwiftUI

struct ServiceProviderReportsEntryView: View {
    @ObservedObject var reportsVM:ServiceProviderReportsEntryViewModel
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack (spacing: 3) {
                Image("folder")
                    .scaleEffect(0.8)
                    .foregroundColor(Color.gray)

                Text("REPORTS")
                    .font(.footnote)
                    .foregroundColor(Color.black.opacity(0.4))
                    .bold()
            }

            if !self.reportsVM.imagesToUpload.isEmpty {
                ScrollView (.horizontal) {
                    HStack {
                        ForEach (self.reportsVM.imagesToUpload, id: \.self) { imageData in
                            ImageViewWithData(data: imageData)
                        }
                    }
                }
            } else {
                HStack {
                    Text("You have uploaded 0 Reports")
                    Spacer()
                }.padding(.top, 5)
            }

            LargeButton(title: self.reportsVM.imagesToUpload.count > 0 ? "Upload Another" : "Upload Image", backgroundColor: Color.blue) {
                EndEditingHelper.endEditing()
                LoggerService().log(eventName: "Service Provider Click upload report button in normal report view")
                reportsVM.imagePickerVM.showActionSheet()
            }
            .modifier(ImagePickerModifier(imagePickerVM: self.reportsVM.imagePickerVM))
        }
    }
}
