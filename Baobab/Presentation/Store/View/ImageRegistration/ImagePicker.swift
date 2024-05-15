//
//  ImagePicker.swift
//  Baobab
//
//  Created by 이정훈 on 5/14/24.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @EnvironmentObject private var viewModel: StoreViewModel
    @Environment(\.dismiss) private var dismiss
    
    private let sourceType: UIImagePickerController.SourceType
    private let index: Int
    
    init(for sourceType: UIImagePickerController.SourceType, selectedIndex: Int) {
        self.sourceType = sourceType
        self.index = selectedIndex
    }
    
    //MARK: - ViewController
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType    //ImagePicker의 종류 설정
        imagePicker.allowsEditing = true    //이미지 편집기능 활성화
        imagePicker.delegate = context.coordinator
        
        return imagePicker
    }
        
    func updateUIViewController(_ uiViewController: UIImagePickerController, 
                                context: UIViewControllerRepresentableContext<ImagePicker>) {}
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(imagePicker: self)
    }
}

//MARK: - Coordinator
extension ImagePicker {
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        private var imagePicker: ImagePicker

        init(imagePicker: ImagePicker) {
            self.imagePicker = imagePicker
        }
        
        //MARK: - Delegate method executed after Image Selection
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                imagePicker.viewModel.itemImages[imagePicker.index] = image
            }
            
            imagePicker.dismiss()    //사진 선택 후 View 닫음
        }
    }
}
