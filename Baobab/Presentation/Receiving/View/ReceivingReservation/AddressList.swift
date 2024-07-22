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
            VStack {
                Text("방문지 변경")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.headline)
                    .padding([.leading, .trailing, .top])
                
                List {
                    Section(header: Text("기본 방문지")) {
                        AddressListRow(address: viewModel.defaultAddress)
                            .padding(10)
                            .alignmentGuide(.listRowSeparatorLeading) { _ in
                                return 0    //List row 하단 구분선 여백 없음
                            }
                    }
                    
                    Section(header: Text("등록된 방문지")) {
                        ForEach(viewModel.registeredAddresses) { address in
                            AddressListRow(address: address)
                                .padding(10)
                                .alignmentGuide(.listRowSeparatorLeading) { _ in
                                    return 0    //List row 하단 구분선 여백 없음
                                }
                        }
                    }
                }
                .listStyle(.plain)
                
                Button(action: {
                    isShowingPostCodeSearch = true
                }, label: {
                    Text("새로운 방문지 선택")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke()
                        }
                        .foregroundColor(.gray)
                })
                .padding()
            }
            .onAppear {
                viewModel.fetchAddresses()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        isShowingAddressList.toggle()
                    }, label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                    })
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
