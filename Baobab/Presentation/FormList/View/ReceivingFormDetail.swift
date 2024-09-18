//
//  ReceivingFormDetail.swift
//  Baobab
//
//  Created by 이정훈 on 7/30/24.
//

import SwiftUI

struct ReceivingFormDetail: View {
    @Environment(\.dismiss) private var dismiss
    
    let form: ReceivingForm
    
    var body: some View {
        List {
            Section(footer: SectionFooter()) {
                VStack(alignment: .leading) {
                    Text(form.status)
                        .font(.headline)
                        .padding(.top)
                        .padding(.bottom, 40)
                    
                    ProcessStatusBar(percentile: form.statusPercentile ?? 0,
                                     type: .receivingForm)
                    
                    Text(form.statusDescription)
                        .foregroundStyle(.gray)
                        .font(.subheadline)
                        .padding(.bottom)
                    
                    Text("요청서 번호 : \(form.id)")
                        .foregroundStyle(.gray)
                        .font(.subheadline)
                    
                    Text("픽업 예정일 : \(Date.toSimpleFormat(from: form.visitDate, format: .full))")
                        .foregroundStyle(.gray)
                        .font(.subheadline)
                }
            }
            .listRowSeparator(.hidden)
            
            Section(footer: SectionFooter()) {
                VStack(alignment: .leading) {
                    Text("방문지 정보")
                        .font(.headline)
                        .padding(.bottom)
                    
                    Text(form.visitAddress)
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                }
            }
            .listRowSeparator(.hidden)
            
            Section {
                ForEach(form.items) { item in
                    NavigationLink(destination: {
                        ItemDetailView(viewModel: AppDI.shared.makeItemStatusConversionViewModel(),
                                       itemViewModel: AppDI.shared.makeItemViewModel(),
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
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                }
            }
        }
    }
}

#if DEBUG
#Preview {
    NavigationStack {
        ReceivingFormDetail(form: ReceivingForm.sampleData[0])
    }
}
#endif
