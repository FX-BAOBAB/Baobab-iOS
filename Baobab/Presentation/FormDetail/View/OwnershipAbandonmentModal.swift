//
//  OwnershipAbandonmentModal.swift
//  Baobab
//
//  Created by 이정훈 on 8/24/24.
//

import SwiftUI

struct OwnershipAbandonmentModal: View {
    @EnvironmentObject private var viewModel: FormDetailViewModel
    @Binding var isShowingOwnershipAbandonmentSheet: Bool
    
    let formId: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("물품 소유권 포기")
                    .font(.title3)
                    .bold()
                
                Spacer()
                
                Button {
                    isShowingOwnershipAbandonmentSheet.toggle()
                } label: {
                    Image(systemName: "x.circle.fill")
                        .foregroundColor(.gray)
                }
            }
            .padding(.bottom)
            
            Text("물품이 더 이상 필요하지 않다면,")
                .foregroundStyle(.gray)
                .font(.subheadline)
            
            HStack(spacing: 0) {
                Text("Baobab")
                    .bold()
                
                Text("에게 맡겨주세요.")
            }
            .font(.subheadline)
            .foregroundStyle(.gray)
            
            HStack(spacing: 0) {
                Text("Baobab")
                    .bold()
                
                Text("이 대신 처리해 드립니다.")
            }
            .font(.subheadline)
            .foregroundStyle(.gray)
            
            Spacer()
            
            HStack {
                Button {
                    isShowingOwnershipAbandonmentSheet.toggle()
                } label: {
                    CancelButtonLabel(title: "취소")
                }
                
                Button {
                    viewModel.abandonOwnership(formId: formId)
                } label: {
                    ConfirmationButtonLabel(title: "소유권 포기")
                }
            
            }
        }
        .padding()
    }
}

#Preview {
    OwnershipAbandonmentModal(isShowingOwnershipAbandonmentSheet: .constant(true),
                              formId: 0)
        .environmentObject(AppDI.shared.makeFormDetailViewModel())
}
