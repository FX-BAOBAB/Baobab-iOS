//
//  DefectFullScreenView.swift
//  Baobab
//
//  Created by 이정훈 on 9/5/24.
//

import SwiftUI

struct DefectFullScreenView: View {
    @Binding var isShowingFullScreen: Bool
    
    let imageData: ImageData
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                AsyncImage(url: URL(string: imageData.imageURL)) { image in
                    image
                        .resizable()
                } placeholder: {
                    Rectangle()
                        .fill(.gray)
                        .overlay {
                            ProgressView()
                        }
                }
                .frame(width: UIScreen.main.bounds.width,
                       height: UIScreen.main.bounds.width)
                
                Text(imageData.caption)
                    .font(.caption)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
            }
        }
        .toolbarBackground(.hidden, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    isShowingFullScreen.toggle()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        DefectFullScreenView(isShowingFullScreen: .constant(true),
                             imageData: ImageData(imageURL: "string", caption: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."))
    }
}
