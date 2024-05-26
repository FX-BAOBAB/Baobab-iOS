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
    
    private let index: Int
    private let sourceType: UIImagePickerController.SourceType    //카메라, 사진 라이브러리 타입 지정
    
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
            if let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage,
               let imageData = uiImage.pngData() {
                //UIImage를 Data 타입으로 변경하여 저장
                imagePicker.viewModel.items[imagePicker.viewModel.itemIdx].itemImages[imagePicker.index] = imageData
            }
            
            imagePicker.dismiss()    //사진 선택 후 View 닫음
        }
    }
}
