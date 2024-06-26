//
//  ReceivingPaymentView.swift
//  Baobab
//
//  Created by 이정훈 on 6/25/24.
//

import SwiftUI

struct ReceivingPaymentView: View {
    @EnvironmentObject private var viewModel: ReceivingViewModel
    @State private var isShowingPaymentAlert: Bool = false
    @State private var isShowingCompletionView: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            List {
                Section(header: Text("입고물품").foregroundColor(.black),
                        footer: SectionFooter()) {
                    ForEach(0..<viewModel.itemIdx + 1, id: \.self) { idx in
                        ItemListRow(idx: idx)
                            .environmentObject(viewModel)
                            .listRowSeparator(.hidden)
                            .alignmentGuide(.listRowSeparatorLeading) { _ in return 0 }
                    }
                }
                .listSectionSeparator(.hidden)
                
                Section(header: Text("결제금액").foregroundColor(.black)) {
                    PaymentDetail()
                        .environmentObject(viewModel)
                }
                .listSectionSeparator(.hidden, edges: .top)
                .listSectionSeparator(.hidden, edges: .bottom)
            }
            .listStyle(.plain)
            
            HStack(spacing: 3) {
                Spacer()

                Image(systemName: "info.circle")
                
                Text("위 내용을 확인하였으며 결제에 동의합니다.")
                
                Spacer()
            }
            .foregroundColor(.gray)
            .font(.caption)
            .padding([.leading, .trailing])
            
            Button(action: {
                isShowingPaymentAlert.toggle()
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
        }
        .navigationTitle("결제")
        .alert(isPresented: $isShowingPaymentAlert) {
            Alert(title: Text("알림"), 
                  message: Text("결제를 진행할까요?"),
                  primaryButton: .default(Text("확인")) { isShowingCompletionView.toggle() },
                  secondaryButton: .default(Text("취소")))
        }
        .navigationDestination(isPresented: $isShowingCompletionView) {
            ReceiptCompletionView()
                .environmentObject(viewModel)
        }
    }
}

#Preview {
    NavigationStack {
        ReceivingPaymentView()
            .environmentObject(AppDI.shared.receivingViewModel)
    }
}
