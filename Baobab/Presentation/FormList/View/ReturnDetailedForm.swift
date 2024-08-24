//
//  ReturnDetailedForm.swift
//  Baobab
//
//  Created by 이정훈 on 8/5/24.
//

import SwiftUI

struct ReturnDetailedForm: View {
    let form: ReturnForm
    
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
                    
                    Text("반품 신청일 : \(Date.toSimpleFormat(from: form.takeBackRequestAt, format: .withoutTime))")
                        .foregroundStyle(.gray)
                        .font(.subheadline)
                }
            }
            .listRowSeparator(.hidden)
            
            Section {
                ForEach(form.items) { item in
                    NavigationLink(destination: {
                        ItemDetailView(viewModel: AppDI.shared.makeItemStatusConversionViewModel(),
                                       item: item)
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
        ReturnDetailedForm(form: ReturnForm.sampleData[0])
    }
}
#endif
