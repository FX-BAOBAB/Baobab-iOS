//
//  CameraLabel.swift
//  Baobab
//
//  Created by 이정훈 on 6/24/24.
//

import SwiftUI

struct CameraLabel: View {
    private let width: Double
    private let height: Double
    private let font: Font
    
    init(width: Double, height: Double? = nil, font: Font) {
        self.width = width
        self.height = height ?? width
        self.font = font
    }
    
    var body: some View {
        VStack(spacing: 3) {
            Image(systemName: "camera.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width, height: height)
            
            Text("사진추가")
                .font(font)
        }
        .foregroundColor(.gray)
    }
}

#Preview {
    CameraLabel(width: UIScreen.main.bounds.width * 0.08, font: .body)
}
