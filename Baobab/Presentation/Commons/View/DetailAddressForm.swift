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
                    CancelButtonLabel(title: "취소")
                }
                
                Button {
                    viewModel.registerAsSelectedAddress()
                    isShowingPostSearchForm.toggle()
                    isShowingAddressList.toggle()
                } label: {
                    ConfirmationButtonLabel(title: "확인")
                }
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
