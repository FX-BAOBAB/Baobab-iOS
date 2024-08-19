//
//  ShippingApplicationCompletionView.swift
//  Baobab
//
//  Created by 이정훈 on 8/19/24.
//

import SwiftUI

struct ShippingApplicationCompletionView: View {
    @EnvironmentObject private var viewModel: ShippingApplicationViewModel
    @State private var isFirstAppear: Bool = true
    @Binding var isShowingFullScreenCover: Bool
    
    var body: some View {
        VStack {
            if viewModel.isProgress {
                ProgressView()
            } else {
                VStack {
                    Spacer()
                    
                    if viewModel.result == .success {
                        Image("verify")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80)
                            .padding(.bottom, 10)
                        
                        Text("출고 예약에 성공 했어요!")
                            .bold()
                            .foregroundStyle(.gray)
                    } else if viewModel.result == .failure {
                        Image("xicon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80)
                            .padding(.bottom, 10)
                        
                        VStack(spacing: 3) {
                            Text("출고 예약에 실패 했어요.")
                            
                            Text("고객센터로 문의 바랍니다.")
                        }
                        .bold()
                        .foregroundStyle(.gray)
                    }
                    
                    Spacer()
                    
                    Button {
                        isShowingFullScreenCover.toggle()
                    } label: {
                        Text("확인")
                            .bold()
                            .padding(8)
                            .frame(maxWidth: .infinity)
                    }
                    .buttonBorderShape(.roundedRectangle)
                    .cornerRadius(10)
                    .buttonStyle(.borderedProminent)
                    .background(.white)
                }
                .onAppear {
                    if isFirstAppear {
                        viewModel.applyShipping()
                        isFirstAppear = false
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    ShippingApplicationCompletionView(isShowingFullScreenCover: .constant(true))
        .environmentObject(AppDI.shared.shippingApplicationViewModel)
}
