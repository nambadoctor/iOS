//
//  ImagePicker.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 3/28/21.
//
 
import Foundation
import SwiftUI
import ImagePickerView

struct ImagePickerModifier: ViewModifier {
    @ObservedObject var imagePickerVM:ImagePickerViewModel
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $imagePickerVM.shouldPresentImagePicker) {
                SUImagePickerView(sourceType: self.imagePickerVM.shouldPresentCamera ? .camera : .photoLibrary, image: self.$imagePickerVM.image, isPresented: self.$imagePickerVM.shouldPresentImagePicker, imagePickedDelegate: self.imagePickerVM.imagePickerDelegate!)
            }.actionSheet(isPresented: $imagePickerVM.shouldPresentActionScheet) { () -> ActionSheet in
                        ActionSheet(title: Text("Choose mode"), message: Text("Please choose your preferred mode to set your profile image"), buttons: [ActionSheet.Button.default(Text("Camera"), action: {
                            self.imagePickerVM.showCamera()
                        }), ActionSheet.Button.default(Text("Photo Library"), action: {
                            self.imagePickerVM.showPhotoLibrary()
                        }), ActionSheet.Button.cancel()])
                    }
    }
}

struct MultipleImagePickerModifier: ViewModifier {
    @ObservedObject var imagePickerVM:MultipleImagePickerViewModel
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $imagePickerVM.shouldPresentImagePicker) {
                ImagePickerView(filter: .any(of: [.images]), selectionLimit: 0, delegate: ImagePickerView.Delegate(isPresented: $imagePickerVM.shouldPresentImagePicker, didCancel: { (phPickerViewController) in
                    print("Did Cancel: \(phPickerViewController)")
                }, didSelect: { (result) in
                    let phPickerViewController = result.picker
                    let images = result.images
                    print("Did Select images: \(images) from \(phPickerViewController)")
                    self.imagePickerVM.images = images
                }, didFail: { (imagePickerError) in
                    let phPickerViewController = imagePickerError.picker
                    let error = imagePickerError.error
                    print("Did Fail with error: \(error) in \(phPickerViewController)")
                }))
            }.actionSheet(isPresented: $imagePickerVM.shouldPresentActionScheet) { () -> ActionSheet in
                        ActionSheet(title: Text("Choose mode"), message: Text("Please choose your preferred mode to set your profile image"), buttons: [ActionSheet.Button.default(Text("Camera"), action: {
                            self.imagePickerVM.showCamera()
                        }), ActionSheet.Button.default(Text("Photo Library"), action: {
                            self.imagePickerVM.showPhotoLibrary()
                        }), ActionSheet.Button.cancel()])
                    }
    }
}


protocol ImagePickedDelegate {
    func imageSelected()
}

class ImagePickerViewModel:ObservableObject {
    @Published var image: UIImage? = nil
    @Published var shouldPresentImagePicker = false
    @Published var shouldPresentActionScheet = false
    @Published var shouldPresentCamera = false
    var imagePickerDelegate:ImagePickedDelegate? = nil

    func showActionSheet() {
        self.shouldPresentActionScheet = true
    }
    
    func removeImage () {
        self.image = nil
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

struct LocalPickedImageDisplayView : View {
    @ObservedObject var imagePickerVM:ImagePickerViewModel
    var body : some View {
        ZStack {
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
    var body : some View {
        ZStack {
            if imagePickerVM.images != nil && !imagePickerVM.images!.isEmpty {
                HStack {
                    ForEach (self.imagePickerVM.images!, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150, height: 200)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                    }
                }
            }
        }
    }
}

struct SUImagePickerView: UIViewControllerRepresentable {
    
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var image: UIImage?
    @Binding var isPresented: Bool
    var imagePickedDelegate:ImagePickedDelegate
    
    func makeCoordinator() -> ImagePickerViewCoordinator {
        return ImagePickerViewCoordinator(image: $image, isPresented: $isPresented, imagePickerDelegate: self.imagePickedDelegate)
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
    var imagePickerDelegate:ImagePickedDelegate
    
    init(image: Binding<UIImage?>, isPresented: Binding<Bool>, imagePickerDelegate:ImagePickedDelegate) {
        self._image = image
        self._isPresented = isPresented
        self.imagePickerDelegate = imagePickerDelegate
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.image = image
            self.imagePickerDelegate.imageSelected()
        }
        self.isPresented = false
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.isPresented = false
    }
    
}
