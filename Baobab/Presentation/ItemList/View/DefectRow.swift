//
//  DefectRow.swift
//  Baobab
//
//  Created by 이정훈 on 7/26/24.
//

import SwiftUI

struct DefectRow: View {
    @State private var isShowingFullScreen: Bool = false
    
    let imageData: Data
    let caption: String
    
    var body: some View {
        VStack(spacing: 0) {            
            Image(uiImage: UIImage(data: imageData))
                .resizable()
                .frame(width: UIScreen.main.bounds.width * 0.5,
                       height: UIScreen.main.bounds.width * 0.5)
            
            Rectangle()
                .fill(.white)
                .frame(width: UIScreen.main.bounds.width * 0.5, height: 60)
                .overlay {
                    Text(caption)
                        .lineLimit(2)
                        .font(.caption2)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(maxHeight: .infinity, alignment: .top)
                }
        }
        .cornerRadius(10)
        .shadow(radius: 6)
        .padding()
        .onTapGesture {
            isShowingFullScreen.toggle()
        }
        .fullScreenCover(isPresented: $isShowingFullScreen) {
            NavigationStack {
                DefectFullScreenView(isShowingFullScreen: $isShowingFullScreen,
                                     imageData: imageData,
                                     caption: caption)
            }
        }
    }
}

#Preview {
    DefectRow(imageData: Data(), caption: "테스트")
}
