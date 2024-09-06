//
//  UsedTradeSearchView.swift
//  Baobab
//
//  Created by 이정훈 on 9/6/24.
//

import SwiftUI

struct UsedTradeSearchView: View {
    @StateObject private var viewModel: UsedTradeSearchViewModel
    @Binding var isShowingUsedItemSearch: Bool
    
    init(viewModel: UsedTradeSearchViewModel, isShowingUsedItemSearch: Binding<Bool>) {
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
                            UsedTradeDetail(usedItem: result)
                        } label: {
                            UsedTradeListRow(usedItem: result)
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
        UsedTradeSearchView(viewModel: AppDI.shared.makeUsedTradeSearchViewModel(), isShowingUsedItemSearch: .constant(true))
    }
}
