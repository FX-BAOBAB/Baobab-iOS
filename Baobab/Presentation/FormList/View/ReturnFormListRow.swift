//
//  ReturnFormListRow.swift
//  Baobab
//
//  Created by 이정훈 on 8/1/24.
//

import SwiftUI

struct ReturnFormListRow: View {
    @State private var isShowingDetailedView: Bool = false
    
    private let form: ReturnForm?
    
    init(form: ReturnForm?) {
        self.form = form
    }
    
    var body: some View {
        if let form = form {
            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(form.status)
                        .font(.headline)
                    
                    Text("반품 신청일: \(Date.toSimpleFormat(from: form.takeBackRequestAt, format: .simple))")
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
            .navigationDestination(isPresented: $isShowingDetailedView) {
                ReturnDetailedForm(form: form)
            }
        } else {
            Text("Hello World!")
        }
    }
}

#if DEBUG
#Preview {
    NavigationStack {
        ReturnFormListRow(form: ReturnForm.sampleData[0])
    }
}
#endif
