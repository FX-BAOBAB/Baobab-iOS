//
//  ShippingDetailedForm.swift
//  Baobab
//
//  Created by 이정훈 on 8/2/24.
//

import SwiftUI

struct ShippingDetailedForm: View {
    let form: ShippingFormData
    
    var body: some View {
        List {
            Section(footer: SectionFooter()) {
                VStack(alignment: .leading) {
                    Text(form.status)
                        .font(.headline)
                        .padding(.top)
                        .padding(.bottom, 40)
                    
                    ProcessStatusBar(percentile: form.statusPercentile ?? 0, 
                                     type: .shippingForm)
                    
                    Text(form.statusDescription)
                        .foregroundStyle(.gray)
                        .font(.subheadline)
                        .padding(.bottom)
                    
                    Text("요청서 번호 : \(form.id)")
                        .foregroundStyle(.gray)
                        .font(.subheadline)
                    
                    Text("배송 예정일 : \(Date.toSimpleFormat(from: form.deliveryDate, format: .withoutTime))")
                        .foregroundStyle(.gray)
                        .font(.subheadline)
                }
            }
            .listRowSeparator(.hidden)
            
            Section(footer: SectionFooter()) {
                VStack(alignment: .leading) {
                    Text("배송지 정보")
                        .font(.headline)
                        .padding(.bottom)
                    
                    Text(form.deliveryAddress)
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                }
            }
            .listRowSeparator(.hidden)
            
            Section {
                ForEach(form.items) { item in
                    NavigationLink(destination: {
                        DetailedItemView(item: item, status: .receiving)
                    }) {
                        ItemInfoRow(item: item)
                    }
                }
            }
            .padding([.top, .bottom], 10)
            .alignmentGuide(.listRowSeparatorLeading) { _ in
                return 0
            }
        }
        .listStyle(.plain)
        .toolbarBackground(.white, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .navigationTitle("상세보기")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#if DEBUG
#Preview {
    NavigationStack {
        ShippingDetailedForm(form: ShippingFormData.sampleData[0])
    }
}
#endif
