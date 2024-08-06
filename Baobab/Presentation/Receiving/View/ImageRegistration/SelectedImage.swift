//
//  SelectedImage.swift
//  Baobab
//
//  Created by 이정훈 on 5/14/24.
//

import SwiftUI

struct SelectedImage: View {
    @EnvironmentObject private var viewModel: ReceivingViewModel
    @Binding var isShowDialog: Bool
    @Binding var selectedIndex: Int?
    
    let pos: Int
    let title: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 3) {
            Text(title)
                .bold()
                .font(.footnote)
                .foregroundStyle(.gray)
            
            if let imageData = viewModel.items[viewModel.itemIdx].itemImages[pos],
               let uiImage = UIImage(data: imageData) {
                ZStack(alignment: .bottomTrailing) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width * 0.4,
                               height: UIScreen.main.bounds.width * 0.4)
                        .cornerRadius(20)
                        .onTapGesture {
                            isShowDialog.toggle()
                            selectedIndex = pos
                        }
                    
                    Image("ImageEdit")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40)
                }
            } else {
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: UIScreen.main.bounds.width * 0.4,
                           height: UIScreen.main.bounds.width * 0.4)
                    .foregroundColor(Color(red: 243 / 255, green: 242 / 255, blue: 245 / 255))
                    .onTapGesture {
                        isShowDialog.toggle()
                        selectedIndex = pos
                    }
                    .overlay {
                        CameraLabel(width: UIScreen.main.bounds.width * 0.08,
                                    font: .caption)
                    }
            }
        }
    }
}

#Preview {
    SelectedImage(isShowDialog: .constant(false), 
                  selectedIndex: .constant(0),
                  pos: 0, title: "정면")
        .environmentObject(AppDI.shared.receivingViewModel)
}
