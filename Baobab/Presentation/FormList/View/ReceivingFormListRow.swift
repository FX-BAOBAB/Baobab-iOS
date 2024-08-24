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
                    .padding(.bottom)
                    
                    Button(action: {
                        isShowingDetailedView.toggle()
                    }, label: {
                        Text("상세보기")
                            .font(.caption)
                            .frame(maxWidth: .infinity)
                            .padding(10)
                            .overlay {
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke()
                            }
                    })
                    .foregroundStyle(.gray)
                    .buttonStyle(.borderless)
                }
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke()
                        .fill(Color(red: 222 / 255, green: 226 / 255, blue: 230 / 255))
                }
            }
            .padding([.leading, .trailing])
            .padding([.top, .bottom], 25)
            .navigationDestination(isPresented: $isShowingDetailedView) {
                ReceivingFormDetail(form: form)
            }
        } else {
            Text("Hello World!")
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
