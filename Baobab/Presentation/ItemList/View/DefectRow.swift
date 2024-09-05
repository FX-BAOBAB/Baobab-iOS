//
//  DefectRow.swift
//  Baobab
//
//  Created by 이정훈 on 7/26/24.
//

import SwiftUI

struct DefectRow: View {
    @State private var isShowingFullScreen: Bool = false
    
    let imageData: ImageData
    
    var body: some View {
        VStack(spacing: 0) {
            AsyncImage(url: URL(string: imageData.imageURL)) { image in
                image
                    .resizable()
                    .overlay {
                        ZStack {
                            Circle()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.gray)
                            
                            Image(systemName: "arrow.down.left.and.arrow.up.right")
                                .foregroundStyle(.white)
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .frame(maxHeight: .infinity, alignment: .top)
                        .padding(10)
                    }
            } placeholder: {
                Rectangle()
                    .fill(.gray)
                    .overlay {
                        ProgressView()
                    }
            }
            .frame(width: UIScreen.main.bounds.width * 0.5,
                   height: UIScreen.main.bounds.width * 0.5)
            
            Rectangle()
                .fill(.white)
                .frame(width: UIScreen.main.bounds.width * 0.5, height: 60)
                .overlay {
                    Text(imageData.caption)
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
                                     imageData: imageData)
            }
        }
    }
}

#Preview {
    DefectRow(imageData: ImageData(imageURL: "string", caption: "테스트"))
}
