//
//  SelectedImage.swift
//  Baobab
//
//  Created by 이정훈 on 5/14/24.
//

import SwiftUI

struct SelectedImage: View {
    @EnvironmentObject private var viewModel: StoreViewModel
    @Binding var isShowDialog: Bool
    @Binding var selectedIndex: Int?
    
    let pos: Int
    let title: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(title)
                .bold()
                .font(.footnote)
                .padding(.leading)
            
            if let imageData = viewModel.items[viewModel.itemIdx].itemImages[pos],
               let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width * 0.43,
                           height: UIScreen.main.bounds.width * 0.43)
                    .cornerRadius(20)
                    .onTapGesture {
                        isShowDialog.toggle()
                        selectedIndex = pos
                    }
            } else {
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: UIScreen.main.bounds.width * 0.43,
                           height: UIScreen.main.bounds.width * 0.43)
                    .foregroundColor(.gray)
                    .onTapGesture {
                        isShowDialog.toggle()
                        selectedIndex = pos
                    }
                    .overlay {
                        Image(systemName: "plus")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.width * 0.05)
                            .foregroundColor(.white)
                    }
            }
        }
    }
}

#Preview {
    SelectedImage(isShowDialog: .constant(false), 
                  selectedIndex: .constant(0),
                  pos: 0, title: "정면")
        .environmentObject(AppDI.shared.storeViewModel)
}
