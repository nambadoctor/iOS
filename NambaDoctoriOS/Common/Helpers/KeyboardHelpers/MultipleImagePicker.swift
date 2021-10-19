//
//  MultipleImagePicker.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 10/7/21.
//

import Foundation
import SwiftUI
import ImagePickerView

struct MultipleImagePickerModifier: ViewModifier {
    @ObservedObject var imagePickerVM:MultipleImagePickerViewModel
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $imagePickerVM.shouldPresentImagePicker) {
                if self.imagePickerVM.shouldPresentCamera {
                    
                } else {
                    ImagePickerView(filter: .any(of: [.images]), selectionLimit: 0, delegate: ImagePickerView.Delegate(isPresented: $imagePickerVM.shouldPresentImagePicker, didCancel: { (phPickerViewController) in
                        print("Did Cancel: \(phPickerViewController)")
                    }, didSelect: { (result) in
                        let phPickerViewController = result.picker
                        let images = result.images
                        print("Did Select images: \(images) from \(phPickerViewController)")
                        DispatchQueue.main.async {
                            self.imagePickerVM.images = images
                        }
                    }, didFail: { (imagePickerError) in
                        let phPickerViewController = imagePickerError.picker
                        let error = imagePickerError.error
                        print("Did Fail with error: \(error) in \(phPickerViewController)")
                    }))
                }
            }.actionSheet(isPresented: $imagePickerVM.shouldPresentActionScheet) { () -> ActionSheet in
                        ActionSheet(title: Text("Choose mode"), message: Text("Please choose your preferred mode to set your profile image"), buttons: [ActionSheet.Button.default(Text("Camera"), action: {
                            self.imagePickerVM.showCamera()
                        }), ActionSheet.Button.default(Text("Photo Library"), action: {
                            self.imagePickerVM.showPhotoLibrary()
                        }), ActionSheet.Button.cancel()])
                    }
    }
}

class MultipleImagePickerViewModel:ObservableObject {
    @Published var images: [UIImage]? = nil
    @Published var shouldPresentImagePicker = false
    @Published var shouldPresentActionScheet = false
    @Published var shouldPresentCamera = false

    func showActionSheet() {
        self.shouldPresentActionScheet = true
    }
    
    func removeImage (image:UIImage) {
        let indexOfImage = images!.firstIndex(of: image)
        if indexOfImage != nil {
            images!.remove(at: indexOfImage!)
        }
    }
    
    func showCamera() {
        self.shouldPresentImagePicker = true
        self.shouldPresentCamera = true
    }
    
    func showPhotoLibrary () {
        self.shouldPresentImagePicker = true
        self.shouldPresentCamera = false
    }
}

struct MultipleLocalPickedImageDisplayView : View {
    @ObservedObject var imagePickerVM:MultipleImagePickerViewModel
    @State var showEnlarged:Bool = false
    var body : some View {
        ZStack {
            if imagePickerVM.images != nil && !imagePickerVM.images!.isEmpty {
                HStack {
                    ForEach (self.imagePickerVM.images!, id: \.self) { image in
                        ZStack {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 120, height: 160)
                                .cornerRadius(10)
                                .shadow(radius: 10)
                                .onTapGesture {
                                    showEnlarged = true
                                }
                                .sheet(isPresented: self.$showEnlarged, content: {
                                    VStack (alignment: .center) {
                                        HStack {
                                            Spacer()
                                            Button {
                                                self.showEnlarged = false
                                            } label: {
                                                Image("xmark.circle")
                                                    .resizable()
                                                    .frame(width: 35, height: 35)
                                                    .foregroundColor(.blue)
                                            }.padding()
                                        }

                                        Image(uiImage: image)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .draggable()
                                            .pinchToZoom()
                                            .onDisappear() {showEnlarged = false}
                                    }
                                })
                            
                            VStack {
                                HStack {
                                    Spacer()
                                    Image("xmark.circle")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(.red)
                                }
                                Spacer()
                            }.onTapGesture {
                                self.imagePickerVM.removeImage(image: image)
                            }
                        }
                    }
                }
            }
        }
    }
}
