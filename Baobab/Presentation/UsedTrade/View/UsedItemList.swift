//
//  UsedItemList.swift
//  Baobab
//
//  Created by 이정훈 on 8/5/24.
//

import SwiftUI

struct UsedItemList: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .frame(maxHeight: .infinity)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("중고장터")
                        .bold()
                        .font(.title3)
                }
            }
    }
}

#Preview {
    UsedItemList()
}
