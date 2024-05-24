//
//  SelectedAddressDetail.swift
//  Baobab
//
//  Created by 이정훈 on 5/23/24.
//

import SwiftUI

struct SelectedAddressDetail: View {
    @EnvironmentObject private var viewModel: StoreViewModel
    @Binding var isShowingPlaceSearchingForm: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("기본 주소")
                .padding([.leading, .trailing], 8)
                .padding([.top, .bottom], 6)
                .background(.blue)
                .foregroundColor(.white)
                .cornerRadius(5)
                .font(.caption)
                .bold()
                .padding(.bottom, 5)
            
            Text(viewModel.address)
                .underline()
                .padding(.bottom, 8)
            
            Text(viewModel.detailAddress)
                .underline()
                .padding(.bottom, 8)
            
            HStack {
                Text(viewModel.postCode)
                    .underline()
                
                Button(action:{
                    isShowingPlaceSearchingForm.toggle()
                }, label: {
                    Text("주소 변경")
                        .padding(5)
                        .foregroundColor(.gray)
                        .font(.subheadline)
                        .overlay {
                            RoundedRectangle(cornerRadius: 5)
                                .stroke()
                                .foregroundColor(.gray)
                        }
                })
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    SelectedAddressDetail(isShowingPlaceSearchingForm: .constant(false))
        .environmentObject(AppDI.shared.storeViewModel)
}
