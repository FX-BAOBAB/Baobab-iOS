//
//  UserInfoList.swift
//  Baobab
//
//  Created by 이정훈 on 7/22/24.
//

import SwiftUI

struct UserInfoList: View {
    @StateObject private var viewModel: UserInfoViewModel
    @State private var isShowingUserInfoView: Bool = false
    @Binding var isLoggedIn: Bool
    
    init(viewModel: UserInfoViewModel, isLoggedIn: Binding<Bool>) {
        _viewModel = StateObject(wrappedValue: viewModel)
        _isLoggedIn = isLoggedIn
    }
    
    var body: some View {
        List {
            Section {
                Text("요청서")
                    .bold()
                    .foregroundStyle(.gray)
                    .padding(.top)
                
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
            .listRowSeparator(.hidden)
            
            Divider()
                .listRowSeparator(.hidden)
            
            Section {
                Text("내 물품")
                    .bold()
                    .foregroundStyle(.gray)
                
                NavigationLink(destination: {
                    LazyView {
                        TopTabView(firstTitle: "입고 중",
                                   secondTitle: "입고 완료",
                                   firstView: LazyItemList(viewModel: AppDI.shared.makeReceivingItemsViewModel(), status: .receiving),
                                   secondView: LazyItemList(viewModel: AppDI.shared.makeStoredItemsViewModel(), status: .stored),
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
                                   firstView: LazyItemList(viewModel: AppDI.shared.makeShippingItemsViewModel(), status: .shipping),
                                   secondView: LazyItemList(viewModel: AppDI.shared.makeShippedItemsViewModel(), status: .shipped),
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
                                   firstView: LazyItemList(viewModel: AppDI.shared.makeReturnningItemsViewModel(), status: .receiving),
                                   secondView: LazyItemList(viewModel: AppDI.shared.makeReturnedItemsViewModel(), status: .returned),
                                   title: "반품 물품")
                    }
                }) {
                    UserInfoListRow(image: "takeBackItem", title: "반품 물품")
                }
                .listRowSeparator(.hidden)
                
                NavigationLink(destination: {
                    LazyView {
                        LazyItemList(viewModel: AppDI.shared.makeUsedItemsViewModel(), status: .used)
                            .navigationTitle("중고 물품")
                            .navigationBarTitleDisplayMode(.inline)
                    }
                }) {
                    UserInfoListRow(image: "usedItem", title: "중고 물품")
                }
            }
            .listSectionSeparator(.hidden)
        }
        .listStyle(.plain)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    isShowingUserInfoView.toggle()
                } label: {
                    SimpleUserInfoView()
                        .environmentObject(viewModel)
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink(destination: {
                    SettingView(viewModel: AppDI.shared.makeSettingViewModel(),
                                isLoggedIn: $isLoggedIn)
                }) {
                    Image(systemName: "gearshape.fill")
                        .foregroundStyle(.gray)
                }
            }
        }
        .fullScreenCover(isPresented: $isShowingUserInfoView) {
            NavigationStack {
                UserInfoView(isShowingUserInfoView: $isShowingUserInfoView)
            }
        }
    }
}

#Preview {
    NavigationStack {
        UserInfoList(viewModel: AppDI.shared.makeUserInfoViewModel(), isLoggedIn: .constant(true))
    }
}
