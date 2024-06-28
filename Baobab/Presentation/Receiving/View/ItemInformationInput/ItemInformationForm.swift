//
//  ItemInformationForm.swift
//  Baobab
//
//  Created by 이정훈 on 5/10/24.
//

import SwiftUI

struct ItemInformationForm: View {
    @EnvironmentObject private var viewModel: ReceivingViewModel
    @State private var isShowingImageRegistrationForm: Bool = false
    
    var body: some View {
        VStack(spacing: 30) {
            BorderedInputBox(inputValue: $viewModel.items[viewModel.itemIdx].itemName,
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
                isShowingImageRegistrationForm.toggle()
            }, label: {
                Text("다음")
                    .bold()
                    .padding(8)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
            })
            .buttonBorderShape(.roundedRectangle)
            .cornerRadius(10)
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .navigationTitle("물품 정보 입력")
        .navigationBarTitleDisplayMode(.large)
        .navigationDestination(isPresented: $isShowingImageRegistrationForm) {
            ImageRegistrationForm()
                .environmentObject(viewModel)
        }
    }
}

#Preview {
    NavigationStack {
        ItemInformationForm()
            .environmentObject(AppDI.shared.receivingViewModel)
    }
}
