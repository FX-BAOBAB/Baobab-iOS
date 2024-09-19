//
//  DefectFullScreenView.swift
//  Baobab
//
//  Created by 이정훈 on 9/5/24.
//

import SwiftUI

struct DefectFullScreenView: View {
    @Binding var isShowingFullScreen: Bool
    
    let imageData: Data
    let caption: String
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Image(uiImage: UIImage(data: imageData))
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width,
                           height: UIScreen.main.bounds.width)
                
                Text(caption)
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
                             imageData: Data(),
                             caption: "테스트")
    }
}
