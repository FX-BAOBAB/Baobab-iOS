//
//  CategoryPicker.swift
//  Baobab
//
//  Created by 이정훈 on 5/10/24.
//

import SwiftUI

struct CategoryPicker: View {
    @EnvironmentObject private var viewModel: StoreViewModel
    @State private var showCetegoryList: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("카테고리")
                .bold()
                .font(.headline)
                .padding(.leading)
            
            Button(action: {
                showCetegoryList.toggle()
            }, label: {
                HStack {
                    Text(viewModel.items[viewModel.itemIdx].itemCategory ?? "카테고리 선택")
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
                .padding()
            })
            .buttonStyle(.borderless)
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.gray, lineWidth: 1)
            }
            .navigationDestination(isPresented: $showCetegoryList, destination: {
                CategoryList()
                    .environmentObject(viewModel)
            })
        }
    }
}

#Preview {
    CategoryPicker()
        .environmentObject(AppDI.shared.storeViewModel)
}
