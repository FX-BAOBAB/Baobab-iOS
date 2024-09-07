//
//  SearchField.swift
//  Baobab
//
//  Created by 이정훈 on 9/6/24.
//

import SwiftUI

struct SearchField: View {
    @EnvironmentObject private var viewModel: UsedItemSearchViewModel
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color(red: 247 / 255, green: 247 / 255, blue: 247 / 255))
            .frame(height: 40)
            .overlay {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(Color(red: 204 / 255, green: 204 / 255, blue: 205 / 255))
                    
                    TextField("검색어를 입력하세요", text: $viewModel.keyword)
                }
                .padding(.leading)
            }
    }
}

#Preview {
    SearchField()
        .environmentObject(AppDI.shared.makeUsedTradeSearchViewModel())
}
