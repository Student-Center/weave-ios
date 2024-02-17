//
//  CameraView.swift
//  DesignSystem
//
//  Created by Jisu Kim on 2/18/24.
//

import Foundation
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIImagePickerController
    typealias Coordinator = ImagePickerCoordinator
    
    var imageHandler: (Image) -> Void
    
    init(imageHandler: @escaping (Image) -> Void) {
        self.imageHandler = imageHandler
    }
    
    var sourceType: UIImagePickerController.SourceType = .camera
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.allowsEditing = true
        picker.delegate = context.coordinator
        
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    }
    
    func makeCoordinator() -> ImagePicker.Coordinator {
        return ImagePickerCoordinator(imageHandler: imageHandler)
    }
    
    class ImagePickerCoordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        var imageHandler: (Image) -> Void
        
        init(imageHandler: @escaping (Image) -> Void) {
            self.imageHandler = imageHandler
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                imageHandler(Image(uiImage: uiImage))
                picker.dismiss(animated: true)
            }
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }
}

public extension View {
    /// CameraView를 present 합니다.
    func camera(
        isPresented: Binding<Bool>,
        imageHandler: @escaping (Image) -> Void
    ) -> some View {
        fullScreenCover(isPresented: isPresented, content: {
            ImagePicker(imageHandler: imageHandler)
        })
    }
}

