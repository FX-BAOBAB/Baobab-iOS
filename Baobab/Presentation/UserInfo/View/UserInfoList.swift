//
//  UserInfoList.swift
//  Baobab
//
//  Created by 이정훈 on 7/22/24.
//

import SwiftUI

struct UserInfoList: View {
    @StateObject private var viewModel: UserInfoViewModel
    @Binding private var isLoggedIn: Bool
    
    init(viewModel: UserInfoViewModel, isLoggedIn: Binding<Bool>) {
        _viewModel = StateObject(wrappedValue: viewModel)
        _isLoggedIn = isLoggedIn
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
                    
                }) {
                    UserInfoListRow(image: "receiving", title: "입고 요청서")
                }
                .listRowSeparator(.hidden)
                
                NavigationLink(destination: {
                }) {
                    UserInfoListRow(image: "shipping", title: "출고 요청서")
                }
                .listRowSeparator(.hidden)
                
                NavigationLink(destination: {
                    EmptyView()
                }) {
                    UserInfoListRow(image: "takeBack", title: "반품 요청서")
                }
            }
            .listSectionSeparator(.hidden, edges: .top)
            .alignmentGuide(.listRowSeparatorLeading) { _ in
                return 0
            }
            
            Section(header: Text("내 물품")) {
                NavigationLink(destination: {
                    TopTabView(firstTitle: "입고 중",
                               secondTitle: "입고 완료",
                               firstView: ItemList(viewModel: AppDI.shared.receivingItemsViewModel),
                               secondView: ItemList(viewModel: AppDI.shared.storedItemsViewModel), 
                               title: "입고 물품")
                }) {
                    UserInfoListRow(image: "receivingItem", title: "입고 물품")
                }
                .listRowSeparator(.hidden)
                
                NavigationLink(destination: {
                    TopTabView(firstTitle: "출고 중",
                               secondTitle: "출고 완료",
                               firstView: ItemList(viewModel: AppDI.shared.shippingItemsViewModel),
                               secondView: ItemList(viewModel: AppDI.shared.shippedItemsViewModel), 
                               title: "출고 물품")
                }) {
                    UserInfoListRow(image: "shippingItem", title: "출고 물품")
                }
                .listRowSeparator(.hidden)
                
                NavigationLink(destination: {
                    TopTabView(firstTitle: "반품 중",
                               secondTitle: "반품 완료",
                               firstView: ItemList(viewModel: AppDI.shared.receivingItemsViewModel),
                               secondView: ItemList(viewModel: AppDI.shared.returnedItemsViewModel),
                               title: "반품 물품")
                }) {
                    UserInfoListRow(image: "takeBackItem", title: "반품 물품")
                }
                .listRowSeparator(.hidden)
                
                NavigationLink(destination: {
                    ItemList(viewModel: AppDI.shared.usedItemsViewModel)
                        .navigationTitle("중고 물품")
                        .navigationBarTitleDisplayMode(.inline)
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
        UserInfoList(viewModel: AppDI.shared.userInfoViewModel, 
                     isLoggedIn: .constant(true))
    }
}
