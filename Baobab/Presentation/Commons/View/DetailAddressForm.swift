//
//  DetailAddressForm.swift
//  Baobab
//
//  Created by 이정훈 on 5/28/24.
//

import SwiftUI

struct DetailAddressForm<T: PostSearchable>: View {
    @EnvironmentObject private var viewModel: T
    @Binding var isShowingPostSearchForm: Bool
    @Binding var isShowingAddressList: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("상세주소 입력")
                .font(.headline)
            
            Spacer()
            
            Text(viewModel.searchedPostCode)
            
            Text(viewModel.searchedAddress)
            
            TextField("상세주소 입력 (예: ◦◦◦동 ◦◦◦◦호)", text: $viewModel.detailedAddressInput)
                .textFieldStyle(.roundedBorder)
            
            Spacer()
            
            HStack {
                Button {
                    isShowingPostSearchForm.toggle()
                    isShowingAddressList.toggle()
                } label: {
                    HStack(spacing: 5) {
                        Image(systemName: "xmark")
                        
                        Text("취소")
                    }
                    .bold()
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.white)
                    .padding()
                    .background(Color(red: 52 / 255, green: 58 / 255, blue: 64 / 255))
                }
                .buttonBorderShape(.roundedRectangle)
                .cornerRadius(10)
                
                Button {
                    viewModel.registerAsSelectedAddress()
                    isShowingPostSearchForm.toggle()
                    isShowingAddressList.toggle()
                } label: {
                    HStack(spacing: 8) {
                        Image("CheckCircle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20)
                        
                        Text("확인")
                    }
                    .bold()
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.white)
                    .padding()
                    .background(.accent)
                }
                .buttonBorderShape(.roundedRectangle)
                .cornerRadius(10)
            }
        }
        .padding()
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    DetailAddressForm<ReceivingViewModel>(isShowingPostSearchForm: .constant(false),
                      isShowingAddressList: .constant(false))
    .environmentObject(AppDI.shared.makeReceivingViewModel())
}
