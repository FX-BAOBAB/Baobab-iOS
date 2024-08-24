//
//  UserInfoList.swift
//  Baobab
//
//  Created by 이정훈 on 7/22/24.
//

import SwiftUI

struct UserInfoList: View {
    @StateObject private var viewModel: UserInfoViewModel
    
    init(viewModel: UserInfoViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        List {            
            NavigationLink(destination: {
                
            }) {
                SimpleUserInfoView()
                    .environmentObject(viewModel)
                    .alignmentGuide(.listRowSeparatorLeading) { _ in
                        return 0
                    }
            }
            
            Section(header: Text("요청서")) {
                NavigationLink(destination: {
                    LazyView {
                        ReceivingFormList(viewModel: AppDI.shared.makeReceivingFormsViewModel())
                    }
                }) {
                    UserInfoListRow(image: "receiving", title: "입고 요청서")
                }
                .listRowSeparator(.hidden)
                
                NavigationLink(destination: {
                    LazyView {
                        ShippingFormList(viewModel: AppDI.shared.makeShippingFormsViewModel())
                    }
                }) {
                    UserInfoListRow(image: "shipping", title: "출고 요청서")
                }
                .listRowSeparator(.hidden)
                
                NavigationLink(destination: {
                    LazyView {
                        ReturnFormList(viewModel: AppDI.shared.makeReturnFormsViewModel())
                    }
                }) {
                    UserInfoListRow(image: "TakeBack", title: "반품 요청서")
                }
            }
            .listSectionSeparator(.hidden, edges: .top)
            .alignmentGuide(.listRowSeparatorLeading) { _ in
                return 0
            }
            
            Section(header: Text("내 물품")) {
                NavigationLink(destination: {
                    LazyView {
                        TopTabView(firstTitle: "입고 중",
                                   secondTitle: "입고 완료",
                                   firstView: ItemList(viewModel: AppDI.shared.makeReceivingItemsViewModel(), status: .receiving),
                                   secondView: ItemList(viewModel: AppDI.shared.makeStoredItemsViewModel(), status: .stored),
                                   title: "입고 물품")
                    }
                }) {
                    UserInfoListRow(image: "receivingItem", title: "입고 물품")
                }
                .listRowSeparator(.hidden)
                
                NavigationLink(destination: {
                    LazyView {
                        TopTabView(firstTitle: "출고 중",
                                   secondTitle: "출고 완료",
                                   firstView: ItemList(viewModel: AppDI.shared.makeShippingItemsViewModel(), status: .shipping),
                                   secondView: ItemList(viewModel: AppDI.shared.makeShippedItemsViewModel(), status: .shipped),
                                   title: "출고 물품")
                    }
                }) {
                    UserInfoListRow(image: "shippingItem", title: "출고 물품")
                }
                .listRowSeparator(.hidden)
                
                NavigationLink(destination: {
                    LazyView {
                        TopTabView(firstTitle: "반품 중",
                                   secondTitle: "반품 완료",
                                   firstView: ItemList(viewModel: AppDI.shared.makeReturnningItemsViewModel(), status: .receiving),
                                   secondView: ItemList(viewModel: AppDI.shared.makeReturnedItemsViewModel(), status: .returned),
                                   title: "반품 물품")
                    }
                }) {
                    UserInfoListRow(image: "takeBackItem", title: "반품 물품")
                }
                .listRowSeparator(.hidden)
                
                NavigationLink(destination: {
                    LazyView {
                        ItemList(viewModel: AppDI.shared.makeUsedItemsViewModel(), status: .used)
                            .navigationTitle("중고 물품")
                            .navigationBarTitleDisplayMode(.inline)
                    }
                }) {
                    UserInfoListRow(image: "usedItem", title: "중고 물품")
                }
            }
            .listSectionSeparator(.hidden, edges: .top)
            .alignmentGuide(.listRowSeparatorLeading) { _ in
                return 0
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    NavigationStack {
        UserInfoList(viewModel: AppDI.shared.makeUserInfoViewModel())
    }
}
