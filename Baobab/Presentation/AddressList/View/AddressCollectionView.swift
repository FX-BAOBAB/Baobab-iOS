//
//  AddressCollectionView.swift
//  Baobab
//
//  Created by 이정훈 on 10/16/24.
//

import SwiftUI

struct AddressCollectionView: View {
    @StateObject private var viewModel: AddressCollectionViewModel
    @State private var isShowingAddressSearchView: Bool = false
    @Binding var isShowingAddressList: Bool
    
    private let completionHandler: (Address?) -> Void
    
    init(viewModel: AddressCollectionViewModel,
         isShowingAddressList: Binding<Bool>,
         completionHandler: @escaping (Address?) -> Void) {
        _viewModel = StateObject(wrappedValue: viewModel)
        _isShowingAddressList = isShowingAddressList
        self.completionHandler = completionHandler
    }
    
    var body: some View {
        List {
            Section {
                AddressCollectionRow(address: viewModel.defaultAddress)
                    .listRowSeparator(.hidden)
            } header: {
                Text("기본 방문지")
                    .padding(.bottom, 10)
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
                        AddressCollectionRow(address: address)
                            .listRowSeparator(.hidden)
                    }
                }
            } header: {
                Text("등록된 방문지")
                    .padding(.bottom, 10)
            }
        }
        .listStyle(.plain)
        .onAppear {
            viewModel.fetchAddresses()
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    isShowingAddressSearchView.toggle()
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
        .fullScreenCover(isPresented: $isShowingAddressSearchView) {
            NavigationStack {
                AddressSearchView(viewModel: AppDI.shared.makeAddressSearchViewModel(),
                                  isShowingPostCodeSearch: $isShowingAddressSearchView,
                                  isShowingAddressList: $isShowingAddressList,
                                  completionHandler: completionHandler)
            }
        }
    }
}

#Preview {
    NavigationStack {
        AddressCollectionView(viewModel: AppDI.shared.makeAddressCollectionViewModel(),
                              isShowingAddressList: .constant(true)) { _ in
            
        }
    }
}
