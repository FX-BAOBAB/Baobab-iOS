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
                .foregroundStyle(.gray)
                .padding(.leading, 5)
            
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(red: 248 / 255, green: 249 / 255, blue: 250 / 255))
                .frame(height: 50)
                .overlay {
                    Button(action: {
                        showCetegoryList.toggle()
                    }, label: {
                        HStack {
                            if viewModel.items[viewModel.itemIdx].korCategory != nil {
                                Text(viewModel.items[viewModel.itemIdx].korCategory)
                            } else {
                                Text("카테고리 선택")
                                    .foregroundStyle(.black)
                            }
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                        .font(.subheadline)
                        .padding(12)
                    })
                    .buttonStyle(.borderless)
                }
                .navigationDestination(isPresented: $showCetegoryList, destination: {
                    CategoryList()
                        .environmentObject(viewModel)
                })
        }
    }
}

#Preview {
    NavigationStack {
        CategoryPicker()
            .environmentObject(AppDI.shared.makeReceivingViewModel())
    }
}
