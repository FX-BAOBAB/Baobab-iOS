//
//  ReceivingPaymentView.swift
//  Baobab
//
//  Created by 이정훈 on 6/25/24.
//

import SwiftUI

struct ReceivingPaymentView: View {
    @EnvironmentObject private var viewModel: ReceivingViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var isShowingCompletionView: Bool = false
    @Binding var isShowingReceivingForm: Bool
    
    var body: some View {
        ZStack {
            List {
                Section(header: Text("물품 및 결제정보")) {
                    ForEach(0..<viewModel.itemIdx + 1, id: \.self) { idx in
                        ItemListRow(idx: idx)
                            .environmentObject(viewModel)
                            .listRowSeparator(.hidden)
                            .alignmentGuide(.listRowSeparatorLeading) { _ in return 0 }
                    }
                }
                .listSectionSeparator(.hidden)
                
                Section(header: Text("결제금액")) {
                    PaymentDetail()
                        .environmentObject(viewModel)
                }
                .listSectionSeparator(.hidden, edges: .top)
                .listSectionSeparator(.hidden, edges: .bottom)
            }
            .listStyle(.plain)
            .scrollDisabled(viewModel.isProgress)
            
            VStack {
                HStack(spacing: 3) {
                    Image(systemName: "info.circle")
                    
                    Text("위 내용을 확인하였으며 결제에 동의합니다.")
                    
                    Spacer()
                }
                .foregroundColor(.gray)
                .font(.caption)
                .padding([.leading, .trailing])
                
                Button(action: {
                    viewModel.alertType = .paymentAlert
                    viewModel.isShowingAlert = true
                }, label: {
                    Text("결제하기")
                        .bold()
                        .padding(8)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                })
                .buttonBorderShape(.roundedRectangle)
                .cornerRadius(10)
                .buttonStyle(.borderedProminent)
                .padding()
                .disabled(viewModel.isProgress)
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            
            if viewModel.isProgress {
                CustomProgressView()
                    .offset(y: -50)
            }
        }
        .navigationTitle("결제")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(isPresented: $viewModel.isShowingCompletionView) {
            SimpleReceiptCompletionView(isShowingReceivingForm: $isShowingReceivingForm)
                .environmentObject(viewModel)
        }
        .alert(isPresented: $viewModel.isShowingAlert) {
            switch viewModel.alertType {
            case .failure:
                Alert(title: Text("알림"),
                      message: Text("입고 신청에 실패 했어요."))
            case .paymentAlert:
                Alert(title: Text("알림"),
                      message: Text("결제를 진행할까요?"),
                      primaryButton: .default(Text("확인")) { viewModel.applyReceiving() },
                      secondaryButton: .default(Text("취소")))
            default:
                Alert(title: Text(""))
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    viewModel.deleteModelFile()
                    isShowingReceivingForm.toggle()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundStyle(.black)
                }
            }
            
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ReceivingPaymentView(isShowingReceivingForm: .constant(true))
            .environmentObject(AppDI.shared.makeReceivingViewModel())
    }
}
