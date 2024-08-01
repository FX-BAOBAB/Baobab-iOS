//
//  FormListRow.swift
//  Baobab
//
//  Created by 이정훈 on 7/26/24.
//

import SwiftUI

struct FormListRow: View {
    @State private var isShowingDetailedView: Bool = false
    
    private let form: FormData?
    
    init(form: FormData?) {
        self.form = form
    }
    
    var body: some View {
        if let form = form {
            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(form.status)
                        .font(.headline)
//                        .padding(.bottom)
                    
//                    ProcessStatusBar(percentile: form.statusPercentile ?? 0)
                    
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
                .padding([.leading, .trailing])
                .padding([.top, .bottom], 20)
                
                SectionFooter()
            }
            .navigationDestination(isPresented: $isShowingDetailedView) {
                DetailedForm(form: form)
            }
        } else {
            Text("Hello World!")
        }
    }
}

#Preview {
    NavigationStack {
        FormListRow(form: FormData.sampleData[0])
    }
}
