//
//  DetailAddressMap.swift
//  Baobab
//
//  Created by 이정훈 on 5/24/24.
//

import MapKit
import SwiftUI

struct DetailAddressMap<T: PostSearchable>: View {
    @EnvironmentObject private var viewModel: T
    @Binding var isShowingAddressList: Bool
    @Binding var isShowingPostSearchForm: Bool

    var body: some View {
        if let region = viewModel.searchedAddressRegion {
            ZStack {
                VStack {
                    Map(coordinateRegion: Binding(get: {
                        return region
                    }, set: { _ in
                        //업데이트되는 값 무시
                    }), annotationItems: [AnnotationItem(coordinate: region.center)]) { item in
                        MapMarker(coordinate: item.coordinate)
                    }
                    .ignoresSafeArea()
                    .frame(height: UIScreen.main.bounds.height * 0.58)
                    
                    Spacer()
                }
                
                VStack {
                    Spacer()
                    
                    DetailAddressForm<T>(isShowingPostSearchForm: $isShowingPostSearchForm,
                                      isShowingAddressList: $isShowingAddressList)
                    .environmentObject(viewModel)
                    .background(.white)
                    .frame(height: UIScreen.main.bounds.width * 0.7)
                    .cornerRadius(20)
                }
            }
        } else {
            ProgressView()
        }
    }
}

#Preview {
    NavigationStack {
        DetailAddressMap<ReceivingViewModel>(isShowingAddressList: .constant(false),
                         isShowingPostSearchForm: .constant(false))
        .environmentObject(AppDI.shared.makeReceivingViewModel())
    }
}
