//
//  DefectImagePicker.swift
//  Baobab
//
//  Created by 이정훈 on 5/16/24.
//

import UIKit
import SwiftUI

struct DefectImagePicker {
    @Environment(\.dismiss) private var dismiss
    @Binding var selectedImage: UIImage?
    
    let sourceType: UIImagePickerController.SourceType
}

extension DefectImagePicker: UIViewControllerRepresentable {
    //MARK: - ViewController
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.allowsEditing = true
        imagePicker.delegate = context.coordinator
        
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(imagePicker: self)
    }
}

extension DefectImagePicker {
    //MARK: - Coordinator
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        private let imagePicker: DefectImagePicker
        
        init(imagePicker: DefectImagePicker) {
            self.imagePicker = imagePicker
        }
        
        //MARK: - Delegate method executed after Image Selection
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                let squareImage = cropToSquare(image: image)
                imagePicker.selectedImage = squareImage
            }
            
            imagePicker.dismiss()    //dismiss Imagepicker instance
        }
        
        private func cropToSquare(image: UIImage) -> UIImage {
            let originalWidth  = image.size.width
            let originalHeight = image.size.height
            let cropSize = min(originalWidth, originalHeight)    //가로, 세로 중 더 짧은 길이 선택
            let cropRect = CGRect(
                x: (originalWidth - cropSize) / 2.0,
                y: (originalHeight - cropSize) / 2.0,
                width: cropSize,
                height: cropSize
            ).integral
            
            guard let croppedCGImage = image.cgImage?.cropping(to: cropRect) else {
                return image
            }
            
            return UIImage(cgImage: croppedCGImage, scale: image.scale, orientation: image.imageOrientation)
        }
    }
}
