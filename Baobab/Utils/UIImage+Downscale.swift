//
//  UIImage+Downscale.swift
//  Baobab
//
//  Created by 이정훈 on 6/24/24.
//

import UIKit

extension UIImage {
    func downscaleToJpegData(maxBytes: UInt) -> Data? {
        var quality: Double = 1.0
        
        while quality > 0 {
            guard let jpegData = self.jpegData(compressionQuality: quality) else {
                return nil
            }
            
            if jpegData.count <= maxBytes {
                return jpegData
            }
            
            quality -= 0.1
        }
        
        return nil
    }
}
