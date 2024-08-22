//
//  LazyStoredItemDetailView.swift
//  Baobab
//
//  Created by 이정훈 on 8/22/24.
//

import SwiftUI

struct LazyStoredItemDetailView: View {
    @EnvironmentObject private var viewModel: StoredItemsViewModel
    @Environment(\.dismiss) private var dismiss
    
    let item: Item
    let status: ItemStatus
    
    
    var body: some View {
        StoredItemDetailView(item: item, status: status)
//        .onChange(of: isShowingFullScreenCover) {
//            if !isShowingFullScreenCover {
//                //중고 전환 신청 완료 후 물품 리스트 업데이트
//                //물품 리스트로 나감
//                viewModel.fetchItems()
//                dismiss()
//            }
//        }
    }
}

#Preview {
    LazyStoredItemDetailView(item: Item(id: 0,
                                        name: "부끄부끄 마끄부끄",
                                        category: "SMALL_APPLIANCES",
                                        quantity: 1,
                                        basicImages: [ImageData(imageURL: "string", caption: ""),
                                                      ImageData(imageURL: "string", caption: "")],
                                        defectImages: [ImageData(imageURL: "", caption: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
                                                       ImageData(imageURL: "string", caption: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")]),
                             status: .stored)
    .environmentObject(AppDI.shared.makeStoredItemsViewModel())
}
