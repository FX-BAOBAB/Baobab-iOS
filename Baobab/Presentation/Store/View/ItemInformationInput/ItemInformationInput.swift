//
//  ItemInformationInput.swift
//  Baobab
//
//  Created by 이정훈 on 5/10/24.
//

import SwiftUI

struct ItemInformationInput: View {
    @ObservedObject private var viewModel: StoreViewModel
    @State private var isShowingNextView: Bool = false
    
    init(viewModel: StoreViewModel) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                ItemInformationInputBox(inputValue: $viewModel.itemName,
                                        title: "물품명",
                                        placeholder: "물품 이름을 입력해 주세요")
                
                CategoryPicker()
                    .environmentObject(viewModel)
                
                ItemQuantitySelector()
                    .environmentObject(viewModel)
                    .padding(.top)
                
                Spacer()
                
                EstimatedPrice()
                    .environmentObject(viewModel)
                    .padding([.leading, .trailing], 5)
                
                Button(action: {
                    isShowingNextView.toggle()
                }, label: {
                    Text("다음")
                        .bold()
                        .padding(8)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                })
                .buttonBorderShape(.roundedRectangle)
                .cornerRadius(20)
                .buttonStyle(.borderedProminent)
            }
            .padding()
            .navigationTitle("물품 정보 입력")
            .navigationBarTitleDisplayMode(.large)
            .navigationDestination(isPresented: $isShowingNextView) {
                ImageRegistration()
                    .environmentObject(viewModel)
            }
        }
    }
}

#Preview {
    ItemInformationInput(viewModel: AppDI.shared.storeViewModel)
}
