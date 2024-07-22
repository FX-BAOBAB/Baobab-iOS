//
//  CategoryPicker.swift
//  Baobab
//
//  Created by 이정훈 on 5/10/24.
//

import SwiftUI

struct CategoryPicker: View {
    @EnvironmentObject private var viewModel: ReceivingViewModel
    @State private var showCetegoryList: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("카테고리")
                .bold()
                .font(.footnote)
                .padding(.leading, 5)
            
            Button(action: {
                showCetegoryList.toggle()
            }, label: {
                HStack {
                    if viewModel.items[viewModel.itemIdx].korCategory != nil {
                        Text(viewModel.items[viewModel.itemIdx].korCategory)
                    } else {
                        Text("카테고리 선택")
                    }
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
                .font(.subheadline)
                .padding(12)
            })
            .buttonStyle(.borderless)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
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
        .environmentObject(AppDI.shared.receivingViewModel)
}
