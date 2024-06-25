//
//  DetailAddressForm.swift
//  Baobab
//
//  Created by 이정훈 on 5/28/24.
//

import SwiftUI

struct DetailAddressForm: View {
    @EnvironmentObject private var viewModel: ReceivingViewModel
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
            
            Button(action: {
                viewModel.registerAsSelectedAddress()
                isShowingPostSearchForm.toggle()
                isShowingAddressList.toggle()
            }, label: {
                Text("방문지로 등록")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding(8)
            })
            .buttonBorderShape(.roundedRectangle)
            .cornerRadius(10)
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    DetailAddressForm(isShowingPostSearchForm: .constant(false),
                      isShowingAddressList: .constant(false))
    .environmentObject(AppDI.shared.receivingViewModel)
}
