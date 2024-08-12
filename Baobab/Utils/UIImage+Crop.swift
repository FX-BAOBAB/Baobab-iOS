//
//  UIImage+Crop.swift
//  Baobab
//
//  Created by 이정훈 on 6/24/24.
//

import UIKit

extension UIImage {
    func cropToSquare() -> UIImage {
        let originalWidth  = self.size.width
        let originalHeight = self.size.height
        let cropSize = min(originalWidth, originalHeight)    //가로, 세로 중 더 짧은 길이 선택
        let cropRect = CGRect(
            x: (originalWidth - cropSize) / 2.0,
            y: (originalHeight - cropSize) / 2.0,
            width: cropSize,
            height: cropSize
        ).integral
        
        guard let croppedCGImage = self.cgImage?.cropping(to: cropRect) else {
            return self
        }
        
        return UIImage(cgImage: croppedCGImage)
    }
}
