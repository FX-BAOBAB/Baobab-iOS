//
//  DetailAddressForm.swift
//  Baobab
//
//  Created by 이정훈 on 5/24/24.
//

import SwiftUI

struct DetailAddressForm: View {
    @EnvironmentObject private var viewModel: StoreViewModel
    @State private var detailAddress: String = ""
    @Binding var address: String
    @Binding var postCode: String
    @Binding var isShowingAddressList: Bool
    @Binding var isShowingPostSearchForm: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Text("우편번호")
                
                Text(postCode)
                    .foregroundColor(.gray)
                    .padding(10)
                    .background(Color(red: 242 / 255, green: 242 / 255, blue: 242 / 255))
                    .cornerRadius(10)
                
            }
            
            HStack {
                Text("주소")
                
                Text(address)
                    .foregroundColor(.gray)
                    .padding(10)
                    .background(Color(red: 242 / 255, green: 242 / 255, blue: 242 / 255))
                    .cornerRadius(10)
            }
            
            TextField("상세주소 입력", text: $detailAddress)
                .textFieldStyle(.roundedBorder)
            
            Spacer()
            
            Button(action: {
                viewModel.address = address
                viewModel.detailAddress = detailAddress
                viewModel.postCode = postCode
                isShowingPostSearchForm.toggle()
                isShowingAddressList.toggle()
            }, label: {
                Text("방문지로 등록")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding(8)
            })
            .buttonBorderShape(.roundedRectangle)
            .cornerRadius(20)
            .buttonStyle(.borderedProminent)
        }
        .padding([.leading, .trailing, .top])
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    NavigationStack {
        DetailAddressForm(address: .constant("경기 성남시 분당구 대왕판교로606번길 45"),
                          postCode: .constant("13524"),
                          isShowingAddressList: .constant(false),
                          isShowingPostSearchForm: .constant(false))
        .environmentObject(AppDI.shared.storeViewModel)
    }
}
