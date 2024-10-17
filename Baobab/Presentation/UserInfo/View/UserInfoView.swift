//
//  UserInfoView.swift
//  Baobab
//
//  Created by 이정훈 on 8/26/24.
//

import SwiftUI

struct UserInfoView: View {
    @StateObject private var viewModel: UserInfoViewModel
    @State private var isShowingAddressList: Bool = false
    @Binding var userInfo: UserInfo?
    @Binding var isShowingUserInfoView: Bool
    
    init(viewModel: UserInfoViewModel, userInfo: Binding<UserInfo?>, isShowingUserInfoView: Binding<Bool>) {
        _viewModel = StateObject(wrappedValue: viewModel)
        _userInfo = userInfo
        _isShowingUserInfoView = isShowingUserInfoView
    }
    
    var body: some View {
        if viewModel.isProgress {
            ProgressView()
                .navigationTitle("내 정보")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            isShowingUserInfoView.toggle()
                        } label: {
                            Image(systemName: "xmark")
                                .foregroundStyle(.black)
                        }
                    }
                }
        } else {
            ScrollView {
                VStack(alignment: .leading, spacing: 30) {
                    ProfileView(userInfo: $userInfo)
                        .padding([.top], 30)
                    
                    Divider()
                        .padding([.leading, .trailing])
                    
                    Section {
                        Text("기본정보")
                            .bold()
                        
                        HStack(spacing: 20) {
                            VStack(alignment: .leading, spacing: 20) {
                                Text("이름")
                                
                                Text("이메일")
                                
                                Text("구분")
                            }
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                            
                            VStack(alignment: .leading, spacing: 20) {
                                Text("\(userInfo?.name ?? "")")
                                
                                Text("\(userInfo?.email ?? "")")
                                
                                Text("\(userInfo?.role ?? "")")
                            }
                            .font(.subheadline)
                        }
                        
                    }
                    .padding(.leading)
                    
                    Divider()
                        .padding([.leading, .trailing])
                    
                    Section {
                        HStack {
                            Text("주소정보")
                                .bold()
                            
                            Spacer()
                            
                            Button {
                                isShowingAddressList.toggle()
                            } label: {
                                Text("전체보기")
                                    .font(.subheadline)
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            Text(viewModel.defaultAddress?.post ?? "")
                            
                            Text(viewModel.defaultAddress?.address ?? "")
                            
                            Text(viewModel.defaultAddress?.detailAddress ?? "")
                        }
                        .font(.subheadline)
                    }
                    .padding([.leading, .trailing])
                    
                    Divider()
                        .padding([.leading, .trailing])
                }
            }
            .navigationTitle("내 정보")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                if viewModel.defaultAddress == nil {
                    viewModel.fetchDefaultAddress()
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isShowingUserInfoView.toggle()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(.black)
                    }
                }
            }
            .sheet(isPresented: $isShowingAddressList) {
                NavigationStack {
                    AddressCollectionView(viewModel: AppDI.shared.makeAddressCollectionViewModel(), isShowingAddressList: $isShowingAddressList) { address in
                        guard let address else {
                            return
                        }
                        
                        viewModel.addNewAddress(address: address)
                    }
                    .presentationDragIndicator(.visible)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        UserInfoView(viewModel: AppDI.shared.makeUserInfoViewModel(),
                     userInfo: .constant(UserInfo(id: 0, name: "홍길동", email: "gildong@baobab.com", role: "unkown")),
                     isShowingUserInfoView: .constant(false))
    }
}
