//
//  SelectedDefectImage.swift
//  Baobab
//
//  Created by 이정훈 on 5/16/24.
//

import SwiftUI

struct SelectedDefectImage: View {
    @Binding var selectedImage: UIImage?
    
    var body: some View {
        if let selectedImage {
            ZStack {
                Image(uiImage: selectedImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .cornerRadius(20)
                
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 60, height: 50)
                    .foregroundColor(.black)
                    .opacity(0.6)
                    .overlay {
                        Text("변경")
                            .foregroundColor(.white)
                    }
            }
        } else {
            RoundedRectangle(cornerRadius: 20)
                .fill(.gray)
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
                .overlay {
                    Image(systemName: "camera.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width * 0.2)
                        .foregroundColor(.white)
                }
        }
    }
}

#Preview {
    SelectedDefectImage(selectedImage: .constant(nil))
}
