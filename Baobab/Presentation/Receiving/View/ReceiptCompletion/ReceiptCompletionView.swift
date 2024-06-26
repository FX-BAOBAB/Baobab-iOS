//
//  ReceiptCompletionView.swift
//  Baobab
//
//  Created by 이정훈 on 6/25/24.
//

import MapKit
import SwiftUI

struct ReceiptCompletionView: View {
    @EnvironmentObject private var viewModel: ReceivingViewModel
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text("입고 접수가 완료되었어요")
                    .bold()
                    .font(.title2)
                
                Text("아래 방문지로 최대한 빨리 방문할 예정이에요")
                    .foregroundColor(.gray)
                    .padding(.bottom, UIScreen.main.bounds.width * 0.2)
                
                SimpleReceivingStatus()
                    .padding(.bottom, UIScreen.main.bounds.width * 0.1)
                
                GroupBox(label: Text("방문지 정보")) {
                    VStack(alignment: .leading, spacing: 15) {
                        SelectedAddressDetail(showTag: false)
                            .environmentObject(viewModel)
                            .font(.caption)
                            .padding(.top)
                        
                        Text(viewModel.reservationDate.toString())
                            .font(.caption)
                    }
                }
                
                if let region = viewModel.region {
                    Map(coordinateRegion: Binding(get: {
                        return region
                    }, set: { _ in
                        //업데이트되는 값 무시
                    }), annotationItems: [AnnotationItem(coordinate: region.center)]) { item in
                        MapMarker(coordinate: item.coordinate)
                    }
                    .frame(height: UIScreen.main.bounds.height * 0.15)
                    .cornerRadius(10)
                }
                
                Spacer()
                
                
            }
            .padding()
            .navigationBarBackButtonHidden()
            
            VStack {
                Spacer()
                
                Button(action: {
                    
                }, label: {
                    Text("완료")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding(8)
                })
                .buttonBorderShape(.roundedRectangle)
                .cornerRadius(10)
                .buttonStyle(.borderedProminent)
                .padding([.leading, .trailing, .bottom])
                .background(.white)
            }
        }
    }
}

#Preview {
    ReceiptCompletionView()
        .environmentObject(AppDI.shared.receivingViewModel)
}
