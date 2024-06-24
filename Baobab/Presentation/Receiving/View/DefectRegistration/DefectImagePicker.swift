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
    @Binding var selectedImage: Data?
    
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
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage,
               let squareImage = image.cropToSquare().downscaleToJpegData(maxBytes: 4_194_304) {
                //이미지는 정방형으로 크롭
                //UIImage를 Data 타입으로 변경하여 저장
                //이미지는 4MB 내외 JPEG 형식으로 다운스케일하여 저장
                imagePicker.selectedImage = squareImage
            }
            
            imagePicker.dismiss()    //dismiss Imagepicker instance
        }
    }
}
