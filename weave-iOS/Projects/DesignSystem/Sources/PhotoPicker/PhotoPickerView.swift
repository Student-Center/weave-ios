//
//  PhotoPickerView.swift
//  DesignSystem
//
//  Created by Jisu Kim on 2/17/24.
//

import SwiftUI
import UIKit
import PhotosUI

public struct PhotoPickerView: UIViewControllerRepresentable {
    
    public typealias UIViewControllerType = PHPickerViewController
    
    let filter: PHPickerFilter
    var limit: Int
    let onComplete: ([UIImage]) -> Void
    
    public init(
        filter: PHPickerFilter = .images,
        limit: Int = 1,
        onComplete: @escaping ([UIImage]) -> Void
    ) {
        self.filter = filter
        self.limit = limit
        self.onComplete = onComplete
    }
    
    public func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = filter
        configuration.selectionLimit = limit
        let controller = PHPickerViewController(configuration: configuration)
        controller.delegate = context.coordinator
        return controller
    }
    
    public func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    public class Coordinator: PHPickerViewControllerDelegate {
        
        private let parent: PhotoPickerView
        
        init(_ parent: PhotoPickerView) {
            self.parent = parent
        }
        
        public func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            var selectedImages: [UIImage] = []
            
            // 취소 버튼으로 눌렀을 때
            if results.isEmpty {
                picker.dismiss(animated: true)
            }
            
            for result in results where result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (image, _ ) in
                    guard let image = image as? UIImage,
                          let self else { return }
                    selectedImages.append(image)
                    self.parent.onComplete(selectedImages)
                    DispatchQueue.main.async {
                        picker.dismiss(animated: true)
                    }
                }
            }
        }
    }
}

public extension View {
    /// PhotoPickerView를 present 합니다.
    func photoPicker(
        isPresented: Binding<Bool>,
        imageHandler: @escaping ([UIImage]) -> Void
    ) -> some View {
        fullScreenCover(isPresented: isPresented, content: {
            PhotoPickerView { images in
                imageHandler(images)
            }
        })
    }
}
