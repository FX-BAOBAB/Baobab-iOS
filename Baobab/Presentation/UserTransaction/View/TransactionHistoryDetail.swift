//
//  TransactionHistoryDetail.swift
//  Baobab
//
//  Created by 이정훈 on 9/11/24.
//

import SwiftUI

struct TransactionHistoryDetail: View {
    @StateObject private var viewModel: TransactionHistoryViewModel
    @Environment(\.dismiss) private var dismiss
    
    private let usedItem: UsedItem
    
    init(viewModel: TransactionHistoryViewModel, usedItem: UsedItem) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.usedItem = usedItem
    }
    
    var body: some View {
        Group {
            if let history = viewModel.history {
                ScrollView {
                    VStack(alignment: .leading) {
                        Text("거래가 완료 되었어요.")
                            .bold()
                            .font(.headline)
                            .foregroundStyle(.accent)
                            .padding([.leading, .top])
                        
                        //물품 정보
                        HStack {
                            AsyncImage(url: URL(string: usedItem.item.basicImages[0].imageURL)) { image in
                                image
                                    .resizable()
                            } placeholder: {
                                Rectangle()
                                    .fill(.gray)
                                    .overlay {
                                        ProgressView()
                                    }
                            }
                            .frame(width: 60, height: 60)
                            .cornerRadius(10)
                            
                            VStack(alignment: .leading) {
                                Text(usedItem.item.name)
                                    .font(.title)
                                    .bold()
                                
                                HStack {
                                    Text(usedItem.item.category.toKorCategory() + ",")
                                    
                                    Text("\(usedItem.item.quantity)개")
                                }
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        SectionFooter()
                        
                        //거래 정보
                        Section(header: Text("거래 정보").bold().padding([.leading, .top])) {
                            TradeInfoView(history: history)
                                .padding([.leading, .top, .bottom])
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            } else {
                ProgressView()
                    .onAppear {
                        if viewModel.history == nil {
                            viewModel.fetchHistroy(usedItemId: usedItem.id)
                        }
                    }
            }
        }
        .navigationTitle("거래 상세")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
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

#if DEBUG
#Preview {
    NavigationStack {
        TransactionHistoryDetail(viewModel: AppDI.shared.makeTransactionHistoryViewModel(),
                                 usedItem: UsedItem.sampleData[0])
    }
}
#endif
