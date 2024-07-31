//
//  FormListRow.swift
//  Baobab
//
//  Created by 이정훈 on 7/26/24.
//

import SwiftUI

struct FormListRow: View {
    @State private var isShowingDetailedView: Bool = false
    
    let form: FormData?
    
    var body: some View {
        if let form = form {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text(form.status)
                        .font(.headline)
                    
                    Spacer()
                    
                    Button(action: {
                        isShowingDetailedView.toggle()
                    }, label: {
                        HStack(spacing: 3) {
                            Text("상세보기")
                            
                            Image(systemName: "chevron.backward")
                                .scaleEffect(x: -1, y: 1, anchor: .center)
                        }
                        .font(.subheadline)
                    })
                    .buttonStyle(.borderless)
                }
                
                Text("픽업 예정일: \(Date.toSimpleFormat(from: form.visitDate, format: .simple))")
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .padding(.bottom)
                
                ForEach(form.items) { item in
                    ItemInfoRow(item: item)
                }
            }
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke()
                    .fill(Color(red: 222 / 255, green: 226 / 255, blue: 230 / 255))
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
        FormListRow(form: FormData.sampleData[1])
    }
}
