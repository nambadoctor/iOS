//
//  ImagePicker.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 3/28/21.
//

import Foundation
import SwiftUI

struct ImagePickerModifier: ViewModifier {
    @ObservedObject var imagePickerVM:ImagePickerViewModel
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $imagePickerVM.shouldPresentImagePicker) {
                SUImagePickerView(sourceType: self.imagePickerVM.shouldPresentCamera ? .camera : .photoLibrary, image: self.$imagePickerVM.image, isPresented: self.$imagePickerVM.shouldPresentImagePicker)
            }.actionSheet(isPresented: $imagePickerVM.shouldPresentActionScheet) { () -> ActionSheet in
                        ActionSheet(title: Text("Choose mode"), message: Text("Please choose your preferred mode to set your profile image"), buttons: [ActionSheet.Button.default(Text("Camera"), action: {
                            self.imagePickerVM.showCamera()
                        }), ActionSheet.Button.default(Text("Photo Library"), action: {
                            self.imagePickerVM.showPhotoLibrary()
                        }), ActionSheet.Button.cancel()])
                    }
    }
}

struct LocalPickedImageDisplayView : View {
    @ObservedObject var imagePickerVM:ImagePickerViewModel
    var body : some View {
        VStack {
            if imagePickerVM.image != nil {
                HStack {
                    Spacer()
                    Image(uiImage: imagePickerVM.image!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 200)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                    Spacer()
                }
            }
        }
    }
}

class ImagePickerViewModel:ObservableObject {
    @Published var image: UIImage? = nil
    @Published var shouldPresentImagePicker = false
    @Published var shouldPresentActionScheet = false
    @Published var shouldPresentCamera = false

    func showActionSheet() {
        self.shouldPresentActionScheet = true
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

struct SUImagePickerView: UIViewControllerRepresentable {
    
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var image: UIImage?
    @Binding var isPresented: Bool
    
    func makeCoordinator() -> ImagePickerViewCoordinator {
        return ImagePickerViewCoordinator(image: $image, isPresented: $isPresented)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let pickerController = UIImagePickerController()
        pickerController.sourceType = sourceType
        pickerController.delegate = context.coordinator
        return pickerController
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // Nothing to update here
    }

}

class ImagePickerViewCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @Binding var image: UIImage?
    @Binding var isPresented: Bool
    
    init(image: Binding<UIImage?>, isPresented: Binding<Bool>) {
        self._image = image
        self._isPresented = isPresented
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.image = image
        }
        self.isPresented = false
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.isPresented = false
    }
    
}
