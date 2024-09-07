//
//  UsedItemSearchView.swift
//  Baobab
//
//  Created by 이정훈 on 9/6/24.
//

import SwiftUI

struct UsedItemSearchView: View {
    @StateObject private var viewModel: UsedItemSearchViewModel
    @Binding var isShowingUsedItemSearch: Bool
    
    init(viewModel: UsedItemSearchViewModel, isShowingUsedItemSearch: Binding<Bool>) {
        _viewModel = StateObject(wrappedValue: viewModel)
        _isShowingUsedItemSearch = isShowingUsedItemSearch
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                SearchField()
                    .environmentObject(viewModel)
                
                Button {
                    isShowingUsedItemSearch.toggle()
                } label: {
                    Text("닫기")
                        .foregroundStyle(.black)
                }
            }
            .padding()
            .onAppear {
                viewModel.bind()
            }
            
            if viewModel.searchResult?.isEmpty == true {
                Spacer()
                
                Text("검색 결과가 없어요.")
                    .foregroundStyle(.gray)
                
                Spacer()
            } else if let results = viewModel.searchResult {
                List {
                    ForEach(results) { result in
                        NavigationLink {
                            UsedItemDetail(viewModel: AppDI.shared.makeUsedItemViewModel(),
                                            usedItem: result)
                        } label: {
                            UsedItemListRow(usedItem: result)
                        }
                        .listRowSeparator(.hidden)
                    }
                }
                .listStyle(.plain)
            } else {
                Spacer()
                
                Text("검색어를 입력하세요.")
                    .foregroundStyle(.gray)
                
                Spacer()
            }
        }
    }
}

#Preview {
    NavigationStack {
        UsedItemSearchView(viewModel: AppDI.shared.makeUsedTradeSearchViewModel(), isShowingUsedItemSearch: .constant(true))
    }
}
