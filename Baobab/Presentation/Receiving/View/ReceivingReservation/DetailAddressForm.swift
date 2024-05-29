//
//  DetailAddressForm.swift
//  Baobab
//
//  Created by 이정훈 on 5/28/24.
//

import SwiftUI

struct DetailAddressForm: View {
    @EnvironmentObject private var viewModel: ReceivingViewModel
    @Binding var address: String
    @Binding var detailAddress: String
    @Binding var postCode: String
    @Binding var isShowingPostSearchForm: Bool
    @Binding var isShowingAddressList: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("상세주소 입력")
                .font(.headline)
                .padding([.bottom, .top])
            
            Text(postCode)
            
            Text(address)
            
            TextField("상세주소 입력 (예: ◦◦◦동 ◦◦◦◦호)", text: $detailAddress)
                .textFieldStyle(.roundedBorder)
            
            Spacer()
            
            Button(action: {
                viewModel.selectedAddress?.id = UUID().hashValue    //임시 난수
                viewModel.selectedAddress?.address = address
                viewModel.selectedAddress?.detailAddress = detailAddress
                viewModel.selectedAddress?.post = postCode
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
    DetailAddressForm(address: .constant("경기 성남시 분당구 대왕판교로606번길 45"),
                      detailAddress: .constant(""),
                      postCode: .constant("13524"),
                      isShowingPostSearchForm: .constant(false),
                      isShowingAddressList: .constant(false))
}
