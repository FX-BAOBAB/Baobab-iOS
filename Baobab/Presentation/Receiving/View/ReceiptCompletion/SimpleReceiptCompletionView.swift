//
//  SimpleReceiptCompletionView.swift
//  Baobab
//
//  Created by 이정훈 on 8/7/24.
//

import SwiftUI

struct SimpleReceiptCompletionView: View {
    @EnvironmentObject private var viewModel: ReceivingViewModel
    @Binding var isShowingReceivingForm: Bool
    
    var body: some View {
        VStack {
            Spacer()
            
            Image("verify")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80)
                .padding(.bottom, 10)
            
            Text("입고 접수가 완료 되었어요!")
                .bold()
                .foregroundStyle(.gray)
            
            Spacer()
            
            Button {
                isShowingReceivingForm.toggle()
            } label: {
                Text("완료")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding(8)
            }
            .buttonBorderShape(.roundedRectangle)
            .cornerRadius(10)
            .buttonStyle(.borderedProminent)
            .padding([.leading, .trailing, .bottom])
            .background(.white)
        }
    }
}

#Preview {
    SimpleReceiptCompletionView(isShowingReceivingForm: .constant(true))
        .environmentObject(AppDI.shared.makeReceivingViewModel())
}
