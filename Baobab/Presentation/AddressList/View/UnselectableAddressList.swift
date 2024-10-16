//
//  UnselectableAddressList.swift
//  Baobab
//
//  Created by 이정훈 on 10/16/24.
//

import SwiftUI

struct UnselectableAddressList: View {
    @StateObject private var viewModel: AddressListViewModel
    
    init(viewModel: AddressListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        List {
            Section {
                UnselectableAddressListRow(address: viewModel.defaultAddress)
                    .listRowSeparator(.hidden)
            } header: {
                Text("기본 방문지")
                    .padding(.bottom)
            }
            
            Section {
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
                        UnselectableAddressListRow(address: viewModel.defaultAddress)
                            .listRowSeparator(.hidden)
                    }
                }
            } header: {
                Text("등록된 방문지")
                    .padding(.bottom)
            }
        }
        .listStyle(.plain)
        .onAppear {
            if viewModel.defaultAddress == nil {
                viewModel.fetchAddresses()
            }
        }
    }
}

#Preview {
    UnselectableAddressList(viewModel: AppDI.shared.makeAddressListViewModel())
}
