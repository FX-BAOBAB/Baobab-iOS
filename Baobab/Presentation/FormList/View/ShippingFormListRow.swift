//
//  ShippingFormListRow.swift
//  Baobab
//
//  Created by 이정훈 on 8/1/24.
//

import SwiftUI

struct ShippingFormListRow: View {
    @State private var isShowingDetailedView: Bool = false
    
    private let form: ShippingFormData?
    
    init(form: ShippingFormData?) {
        self.form = form
    }
    
    var body: some View {
        if let form = form {
            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(form.status)
                        .font(.headline)
                    
                    Text("배송 예정일: \(Date.toSimpleFormat(from: form.deliveryDate, format: .simple))")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .padding(.bottom)
                    
                    ForEach(form.items) { item in
                        ItemInfoRow(item: item)
                    }
                    .padding(.bottom)
                }
                .padding()
                
                Divider()
                
                Button {
                    isShowingDetailedView.toggle()
                } label: {
                    Text("상세보기")
                        .font(.footnote)
                        .foregroundStyle(.black)
                }
                .padding()
                
                SectionFooter()
            }
            .navigationDestination(isPresented: $isShowingDetailedView) {
                ShippingFormDetail(form: form)
            }
        } else {
            EmptyView()
        }
    }
}

#if DEBUG
#Preview {
    NavigationStack {
        ShippingFormListRow(form: ShippingFormData.sampleData[0])
    }
}
#endif
