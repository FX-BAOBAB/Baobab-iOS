//
//  PostCodeSearch.swift
//  Baobab
//
//  Created by 이정훈 on 5/23/24.
//

import SwiftUI

struct PostCodeSearchView<T: PostSearchable>: View {
    @EnvironmentObject private var viewModel: T
    @State private var isProgrss: Bool = true
    @State private var isShowingDetailAddressForm: Bool = false
    @Binding var isShowingPostCodeSearch: Bool
    @Binding var isShowingAddressList: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                PostSearchWebView<T>(isShowingDetailAddressForm: $isShowingDetailAddressForm,
                                  isProgress: $isProgrss)
                .environmentObject(viewModel)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            isShowingPostCodeSearch.toggle()
                        }, label: {
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                        })
                    }
                }
                
                if isProgrss {
                    ProgressView()
                }
            }
            .navigationDestination(isPresented: $isShowingDetailAddressForm) {
                DetailAddressMap<T>(isShowingAddressList: $isShowingAddressList,
                                 isShowingPostSearchForm: $isShowingPostCodeSearch)
                    .environmentObject(viewModel)
            }
        }
    }
}

#Preview {
    PostCodeSearchView<ReceivingViewModel>(isShowingPostCodeSearch: .constant(false), 
                   isShowingAddressList: .constant(false))
        .environmentObject(AppDI.shared.makeReceivingViewModel())
}
