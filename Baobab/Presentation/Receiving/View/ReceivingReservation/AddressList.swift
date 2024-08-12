//
//  AddressList.swift
//  Baobab
//
//  Created by 이정훈 on 5/24/24.
//

import SwiftUI
import SkeletonUI

struct AddressList: View {
    @EnvironmentObject private var viewModel: ReceivingViewModel
    @State private var isShowingPostCodeSearch: Bool = false
    @Binding var isShowingAddressList: Bool
    
    var body: some View {
        NavigationStack {
            List {
                Section(
                    header: Text("기본 방문지")
                        .padding(.bottom)
                ) {
                    AddressListRow(address: viewModel.defaultAddress)
                        .listRowSeparator(.hidden)
                }
                
                Section(
                    header: Text("등록된 방문지")
                        .padding(.bottom)
                ) {
                    if viewModel.registeredAddresses.isEmpty {
                        VStack(spacing: 20) {
                            Image("noAddress")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50)
                            
                            HStack {
                                Spacer()
                                
                                Text("등록된 방문지 정보가 없어요 :(")
                                    .foregroundStyle(.gray)
                                
                                Spacer()
                            }
                        }
                        .padding(.top)
                        .listRowSeparator(.hidden)
                    } else {
                        ForEach(viewModel.registeredAddresses) { address in
                            AddressListRow(address: address)
                                .padding(10)
                                .listRowSeparator(.hidden)
                        }
                    }
                }
            }
            .listStyle(.plain)
            .onAppear {
                viewModel.fetchAddresses()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isShowingPostCodeSearch = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .padding(.top)
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Text("방문지 목록")
                        .bold()
                        .font(.title3)
                        .padding(.top)
                }
            }
            .fullScreenCover(isPresented: $isShowingPostCodeSearch) {
                PostCodeSearch(isShowingPostCodeSearch: $isShowingPostCodeSearch, 
                               isShowingAddressList: $isShowingAddressList)
                    .environmentObject(viewModel)
            }
        }
    }
}

#Preview {
    AddressList(isShowingAddressList: .constant(true))
        .environmentObject(AppDI.shared.receivingViewModel)
}
