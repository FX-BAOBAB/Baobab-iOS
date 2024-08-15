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
                    ReceivingFormList(viewModel: AppDI.shared.receivingFormsViewModel)
                }) {
                    UserInfoListRow(image: "receiving", title: "입고 요청서")
                }
                .listRowSeparator(.hidden)
                
                NavigationLink(destination: {
                    ShippingFormList(viewModel: AppDI.shared.shippingFormsViewModel)
                }) {
                    UserInfoListRow(image: "shipping", title: "출고 요청서")
                }
                .listRowSeparator(.hidden)
                
                NavigationLink(destination: {
                    ReturnFormList(viewModel: AppDI.shared.returnFormsViewModel)
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
                    TopTabView(firstTitle: "입고 중",
                               secondTitle: "입고 완료",
                               firstView: ItemList(viewModel: AppDI.shared.receivingItemsViewModel, status: .receiving),
                               secondView: ItemList(viewModel: AppDI.shared.storedItemsViewModel, status: .stored),
                               title: "입고 물품")
                }) {
                    UserInfoListRow(image: "receivingItem", title: "입고 물품")
                }
                .listRowSeparator(.hidden)
                
                NavigationLink(destination: {
                    TopTabView(firstTitle: "출고 중",
                               secondTitle: "출고 완료",
                               firstView: ItemList(viewModel: AppDI.shared.shippingItemsViewModel, status: .shipping),
                               secondView: ItemList(viewModel: AppDI.shared.shippedItemsViewModel, status: .shipped),
                               title: "출고 물품")
                }) {
                    UserInfoListRow(image: "shippingItem", title: "출고 물품")
                }
                .listRowSeparator(.hidden)
                
                NavigationLink(destination: {
                    TopTabView(firstTitle: "반품 중",
                               secondTitle: "반품 완료",
                               firstView: ItemList(viewModel: AppDI.shared.receivingItemsViewModel, status: .receiving),
                               secondView: ItemList(viewModel: AppDI.shared.returnedItemsViewModel, status: .returned),
                               title: "반품 물품")
                }) {
                    UserInfoListRow(image: "takeBackItem", title: "반품 물품")
                }
                .listRowSeparator(.hidden)
                
                NavigationLink(destination: {
                    ItemList(viewModel: AppDI.shared.usedItemsViewModel, status: .used)
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
            
            Color.clear
                .frame(height: UIScreen.main.bounds.width * 0.21)
                .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
    }
}

#Preview {
    NavigationStack {
        UserInfoList(viewModel: AppDI.shared.userInfoViewModel)
    }
}
