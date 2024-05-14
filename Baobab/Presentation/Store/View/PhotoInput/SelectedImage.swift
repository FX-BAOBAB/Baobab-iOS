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
    
    var title: String
    var pos: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(title)
                .bold()
                .font(.footnote)
                .padding(.leading)
            
            if let image = viewModel.itemImages[pos] {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width * 0.43,
                           height: UIScreen.main.bounds.width * 0.43)
                    .cornerRadius(20)
                
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
                  title: "정면",
                  pos: 0)
        .environmentObject(AppDI.shared.storeViewModel)
}
