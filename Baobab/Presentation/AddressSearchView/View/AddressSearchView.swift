//
//  AddressSearchView.swift
//  Baobab
//
//  Created by 이정훈 on 10/16/24.
//

import SwiftUI

struct AddressSearchView: View {
    @StateObject private var viewModel: AddressSearchViewModel
    @State private var isProgrss: Bool = true
    @State private var isShowingDetailAddressForm: Bool = false
    @Binding var isShowingPostCodeSearch: Bool
    @Binding var isShowingAddressList: Bool
    
    private let completionHandler: (Address?) -> ()
    
    init(viewModel: AddressSearchViewModel,
         isShowingPostCodeSearch: Binding<Bool>,
         isShowingAddressList: Binding<Bool>,
         completionHandler: @escaping (Address?) -> ()) {
        _viewModel = StateObject(wrappedValue: viewModel)
        _isShowingPostCodeSearch = isShowingPostCodeSearch
        _isShowingAddressList = isShowingAddressList
        self.completionHandler = completionHandler
    }
    
    var body: some View {
        ZStack {
            PostSearchWebView<AddressSearchViewModel>(isShowingDetailAddressForm: $isShowingDetailAddressForm, isProgress: $isProgrss)
                .environmentObject(viewModel)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            isShowingPostCodeSearch.toggle()
                        } label: {
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                        }
                    }
                }
            
            if isProgrss {
                ProgressView()
            }
        }
        .navigationDestination(isPresented: $isShowingDetailAddressForm) {
            DetailAddressMap<AddressSearchViewModel>(isShowingAddressList: $isShowingAddressList,
                                                     isShowingPostSearchForm: $isShowingPostCodeSearch,
                                                     completionHandler: completionHandler)
                .environmentObject(viewModel)
        }
        .onAppear {
            viewModel.calculateMapCoordinates()
        }
    }
}

#Preview {
    NavigationStack {
        AddressSearchView(viewModel: AppDI.shared.makeAddressSearchViewModel(),
                          isShowingPostCodeSearch: .constant(true),
                          isShowingAddressList: .constant(false)) { _ in
            //do something
        }
    }
}
