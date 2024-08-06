//
//  SelectedDefectImage.swift
//  Baobab
//
//  Created by 이정훈 on 5/16/24.
//

import SwiftUI

struct SelectedDefectImage: View {
    @Binding var selectedImageData: Data?
    @Binding var isShowingDialog: Bool
    
    var body: some View {
        if let selectedImageData, let uiImage = UIImage(data: selectedImageData){
            ZStack {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
                
                Circle()
                    .frame(width: 30)
                    .foregroundStyle(.gray)
                    .overlay {
                        Image(systemName: "xmark")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 10)
                            .foregroundStyle(.white)
                    }
                    .offset(x: 43, y: -43)
                    .onTapGesture {
                        withAnimation {
                            self.selectedImageData = nil
                        }
                    }
            }
        } else {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(red: 243 / 255, green: 242 / 255, blue: 245 / 255))
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .overlay {
                    CameraLabel(width: UIScreen.main.bounds.width * 0.07,
                                font: .footnote)
                }
                .onTapGesture {
                    isShowingDialog.toggle()
                }
        }
    }
}

#Preview {
    SelectedDefectImage(selectedImageData: .constant(nil), isShowingDialog: .constant(false))
}
