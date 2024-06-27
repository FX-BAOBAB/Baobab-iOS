//
//  ImagePicker.swift
//  Baobab
//
//  Created by 이정훈 on 5/14/24.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @EnvironmentObject private var viewModel: ReceivingViewModel
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
        func imagePickerController(_ picker: UIImagePickerController, 
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage,
               let imageData = cropToSquare(image: uiImage).downscaleToJpegData(maxBytes: 4_194_304) {
                //이미지는 정방형으로 크롭
                //UIImage를 Data 타입으로 변경하여 저장
                //이미지는 4MB 내외 JPEG 형식으로 다운스케일하여 저장
                imagePicker.viewModel.items[imagePicker.viewModel.itemIdx].itemImages[imagePicker.index] = imageData
            }
            
            imagePicker.dismiss()    //사진 선택 후 View 닫음
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
