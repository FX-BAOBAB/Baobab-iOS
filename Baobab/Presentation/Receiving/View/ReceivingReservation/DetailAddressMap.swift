//
//  DetailAddressMap.swift
//  Baobab
//
//  Created by 이정훈 on 5/24/24.
//

import SwiftUI
import MapKit

struct DetailAddressMap: View {
    @EnvironmentObject private var viewModel: ReceivingViewModel
    @State private var detailAddress: String = ""
    @Binding var address: String
    @Binding var postCode: String
    @Binding var isShowingAddressList: Bool
    @Binding var isShowingPostSearchForm: Bool

    
    var body: some View {
        if let region = viewModel.region {
            if #available(iOS 17.0, *) {
                Map(initialPosition: .region(region)) {
                    Marker("방문 위치", systemImage: "figure.wave", coordinate: region.center)
                }
                .ignoresSafeArea()
                .navigationBarBackButtonHidden()
                .sheet(isPresented: .constant(true)) {
                    DetailAddressForm(address: $address,
                                      detailAddress: $detailAddress,
                                      postCode: $postCode,
                                      isShowingPostSearchForm: $isShowingPostSearchForm,
                                      isShowingAddressList: $isShowingAddressList)
                    .environmentObject(viewModel)
                    .interactiveDismissDisabled(true)
                    .presentationDetents([.height(UIScreen.main.bounds.width * 0.7)])
                    .presentationBackgroundInteraction(.enabled(upThrough: .height(UIScreen.main.bounds.width * 0.7)))
                    .presentationDragIndicator(.visible)
                }
            } else {
                ZStack {
                    Map(coordinateRegion: Binding(get: {
                        viewModel.region ?? MKCoordinateRegion()
                    }, set: { _ in
                        //업데이트되는 값 무시
                    }), annotationItems: [AnnotationItem(coordinate: region.center)]) { item in
                        MapMarker(coordinate: item.coordinate)
                    }
                    .ignoresSafeArea()
                    
                    VStack {
                        Spacer()
                        
                        DetailAddressForm(address: $address,
                                          detailAddress: $detailAddress,
                                          postCode: $postCode,
                                          isShowingPostSearchForm: $isShowingPostSearchForm,
                                          isShowingAddressList: $isShowingAddressList)
                        .environmentObject(viewModel)
                        .background(.white)
                        .frame(height: UIScreen.main.bounds.width * 0.7)
                        .interactiveDismissDisabled(true)
                        .presentationDragIndicator(.visible)
                    }
                }
            }
        } else {
            ProgressView()
                .onAppear {
                    viewModel.showLocationOnMap(address)
                }
        }
    }
}

#Preview {
    NavigationStack {
        DetailAddressMap(address: .constant("경기 성남시 분당구 대왕판교로606번길 45"),
                          postCode: .constant("13524"),
                          isShowingAddressList: .constant(false),
                          isShowingPostSearchForm: .constant(false))
        .environmentObject(AppDI.shared.receivingViewModel)
    }
}
