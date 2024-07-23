//
//  UserInfoList.swift
//  Baobab
//
//  Created by 이정훈 on 7/22/24.
//

import SwiftUI

struct UserInfoList: View {
    @ObservedObject private var viewModel: UserInfoViewModel
    
    init(viewModel: UserInfoViewModel) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
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
                    EmptyView()
                }) {
                    UserInfoListRow(image: "receiving", title: "입고 요청서")
                }
                .listRowSeparator(.hidden)
                
                NavigationLink(destination: {
                    EmptyView()
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
                    EmptyView()
                }) {
                    UserInfoListRow(image: "receivingItem", title: "입고 물품")
                }
                .listRowSeparator(.hidden)
                
                NavigationLink(destination: {
                    EmptyView()
                }) {
                    UserInfoListRow(image: "shippingItem", title: "출고 물품")
                }
                .listRowSeparator(.hidden)
                
                NavigationLink(destination: {
                    EmptyView()
                }) {
                    UserInfoListRow(image: "takeBackItem", title: "반품 물품")
                }
                .listRowSeparator(.hidden)
                
                NavigationLink(destination: {
                    EmptyView()
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
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Text("내 정보")
                    .bold()
                    .font(.title3)
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink(destination: {
                    SettingView(viewModel: AppDI.shared.settingViewModel)
                }) {
                    Image(systemName: "gearshape.fill")
                        .foregroundStyle(.gray)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        UserInfoList(viewModel: AppDI.shared.userInfoViewModel)
    }
}
