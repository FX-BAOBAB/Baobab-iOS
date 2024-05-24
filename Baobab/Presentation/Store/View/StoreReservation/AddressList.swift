//
//  AddressList.swift
//  Baobab
//
//  Created by 이정훈 on 5/24/24.
//

import SwiftUI

struct AddressList: View {
    @EnvironmentObject private var viewModel: StoreViewModel
    @Binding var isShowingAddressList: Bool
    @State private var isShowingPostCodeSearch: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("방문지 변경")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.headline)
                
                List {
                    
                }
                
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
            }
            .padding()
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
        .environmentObject(AppDI.shared.storeViewModel)
}
