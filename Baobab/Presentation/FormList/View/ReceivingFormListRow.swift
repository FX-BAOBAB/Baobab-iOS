//
//  ReceivingFormListRow.swift
//  Baobab
//
//  Created by 이정훈 on 7/26/24.
//

import SwiftUI

struct ReceivingFormListRow: View {
    @State private var isShowingDetailedView: Bool = false
    
    private let form: ReceivingForm?
    
    init(form: ReceivingForm?) {
        self.form = form
    }
    
    var body: some View {
        if let form = form {
            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(form.status)
                        .font(.headline)
                    
                    Text("픽업 예정일: \(Date.toSimpleFormat(from: form.visitDate, format: .simple))")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .padding(.bottom)
                    
                    ForEach(form.items) { item in
                        ItemInfoRow(item: item)
                    }
                }
                .padding()
                
                Divider()
                
                Button {
                    isShowingDetailedView.toggle()
                } label: {
                    Text("상세보기")
                        .font(.footnote)
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderless)
                .padding()
                
                SectionFooter()
            }
            .navigationDestination(isPresented: $isShowingDetailedView) {
                ReceivingFormDetail(form: form)
            }
        } else {
            EmptyView()
        }
    }
}

#if DEBUG
#Preview {
    NavigationStack {
        ReceivingFormListRow(form: ReceivingForm.sampleData[0])
    }
}
#endif
