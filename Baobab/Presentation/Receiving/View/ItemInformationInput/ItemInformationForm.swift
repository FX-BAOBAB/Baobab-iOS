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
    @Binding var isShowingReceivingForm: Bool
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 30) {
                    BorderedInputBox(inputValue: $viewModel.items[viewModel.itemIdx].itemName,
                                     title: "물품명",
                                     placeholder: "물품 이름을 입력해 주세요",
                                     type: .normal)
                    
                    BorderedInputBox(inputValue: $viewModel.items[viewModel.itemIdx].modelName,
                                     title: "모델명",
                                     placeholder: "물품의 모델명을 입력해 주세요",
                                     type: .normal)
                    
                    CategoryPicker()
                        .environmentObject(viewModel)
                    
                    ItemQuantitySelector()
                        .environmentObject(viewModel)
                        .padding(.top)
                }
                .padding()
                .navigationTitle("물품 정보 입력")
                .navigationBarTitleDisplayMode(.inline)
                .navigationDestination(isPresented: $isShowingImageRegistrationForm) {
                    ImageRegistrationForm(isShowingReceivingForm: $isShowingReceivingForm)
                        .environmentObject(viewModel)
                }
            }
            
            VStack(spacing: 30) {
                EstimatedPrice()
                    .environmentObject(viewModel)
                    .padding([.leading, .trailing], 5)
                    .ignoresSafeArea(.keyboard)
                
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
            .frame(maxHeight: .infinity, alignment: .bottom)
            .ignoresSafeArea(.keyboard)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    isShowingReceivingForm.toggle()
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ItemInformationForm(isShowingReceivingForm: .constant(true))
            .environmentObject(AppDI.shared.makeReceivingViewModel())
    }
}
