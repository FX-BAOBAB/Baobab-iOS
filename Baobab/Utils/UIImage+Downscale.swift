//
//  UIImage+Downscale.swift
//  Baobab
//
//  Created by 이정훈 on 6/24/24.
//

import UIKit
import Foundation

extension UIImage {
    func downscaleToJpegData(maxBytes: UInt, completion: @escaping @Sendable (Data?) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            var quality: Double = 1.0
            
            while quality > 0 {
                guard let jpegData = self.jpegData(compressionQuality: quality) else {
                    completion(nil)
                    return
                }
                
                if jpegData.count <= maxBytes {
                    completion(jpegData)
                    break
                }
                
                quality -= 0.1
            }
        }
    }
}
