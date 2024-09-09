//
//  UserInfoList.swift
//  Baobab
//
//  Created by 이정훈 on 7/22/24.
//

import SwiftUI

struct UserInfoList: View {
    @State private var isShowingUserInfoView: Bool = false
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        List {
            Section {
                Text("나의 물품")
                    .bold()
                    .foregroundStyle(.gray)
                
                NavigationLink {
                    LazyView {
                        TopTabView(firstTitle: "입고 중",
                                   secondTitle: "입고 완료",
                                   firstView: LazyItemList(viewModel: AppDI.shared.makeReceivingItemsViewModel(), status: .receiving),
                                   secondView: LazyItemList(viewModel: AppDI.shared.makeStoredItemsViewModel(), status: .stored),
                                   title: "입고 물품")
                    }
                } label: {
                    UserInfoListRow(image: "receiving", title: "입고 물품")
                }
                .listRowSeparator(.hidden)
                
                NavigationLink {
                    LazyView {
                        TopTabView(firstTitle: "출고 중",
                                   secondTitle: "출고 완료",
                                   firstView: LazyItemList(viewModel: AppDI.shared.makeShippingItemsViewModel(), status: .shipping),
                                   secondView: LazyItemList(viewModel: AppDI.shared.makeShippedItemsViewModel(), status: .shipped),
                                   title: "출고 물품")
                    }
                } label: {
                    UserInfoListRow(image: "shipping", title: "출고 물품")
                }
                .listRowSeparator(.hidden)
                
                NavigationLink {
                    LazyView {
                        TopTabView(firstTitle: "반품 중",
                                   secondTitle: "반품 완료",
                                   firstView: LazyItemList(viewModel: AppDI.shared.makeReturnningItemsViewModel(), status: .receiving),
                                   secondView: LazyItemList(viewModel: AppDI.shared.makeReturnedItemsViewModel(), status: .returned),
                                   title: "반품 물품")
                    }
                } label: {
                    UserInfoListRow(image: "takeBack", title: "반품 물품")
                }
                .listRowSeparator(.hidden)
            }
            .listSectionSeparator(.hidden)
            
            Divider()
                .listRowSeparator(.hidden)
            
            Section {
                Text("나의 거래")
                    .bold()
                    .foregroundStyle(.gray)
                
                NavigationLink {
                    LazyView {
                        TopTabView(firstTitle: "나의 구매 물품",
                                   secondTitle: "나의 판매 물품",
                                   firstView: TransactionList(viewModel: AppDI.shared.makeUserPurchasedItemsViewModel()),
                                   secondView: TransactionList(viewModel: AppDI.shared.makeUserSoldItemsViewModel()),
                                   title: "거래내역")
                    }
                } label: {
                    UserInfoListRow(image: "transactionHistory", title: "거래내역")
                }
                .listRowSeparator(.hidden)
            }
            .listSectionSeparator(.hidden)
            
            Divider()
                .listRowSeparator(.hidden)
            
            Section {
                Text("요청서")
                    .bold()
                    .foregroundStyle(.gray)
                    .padding(.top)
                
                NavigationLink {
                    LazyView {
                        ReceivingFormList(viewModel: AppDI.shared.makeReceivingFormsViewModel())
                    }
                } label: {
                    UserInfoListRow(image: "receiving", title: "입고 요청서")
                }
                .listRowSeparator(.hidden)
                
                NavigationLink {
                    LazyView {
                        ShippingFormList(viewModel: AppDI.shared.makeShippingFormsViewModel())
                    }
                } label: {
                    UserInfoListRow(image: "shipping", title: "출고 요청서")
                }
                .listRowSeparator(.hidden)
                
                NavigationLink {
                    LazyView {
                        ReturnFormList(viewModel: AppDI.shared.makeReturnFormsViewModel())
                    }
                } label: {
                    UserInfoListRow(image: "takeBack", title: "반품 요청서")
                }
                
                NavigationLink {
                    LazyView {
                        EmptyView()
                    }
                } label: {
                    UserInfoListRow(image: "transaction", title: "거래 요청서")
                }
            }
            .listRowSeparator(.hidden)
            
            Section {
                Color.clear
                    .frame(height: 10)
            }
            .listSectionSeparator(.hidden)
        }
        .listStyle(.plain)
    }
}

#Preview {
    NavigationStack {
        UserInfoList(isLoggedIn: .constant(true))
    }
}
