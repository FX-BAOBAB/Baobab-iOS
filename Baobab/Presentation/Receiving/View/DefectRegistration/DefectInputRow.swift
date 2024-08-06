//
//  DefectRegistrationRow.swift
//  Baobab
//
//  Created by 이정훈 on 5/17/24.
//

import SwiftUI

struct DefectInputRow: View {
    @EnvironmentObject private var viewModel: ReceivingViewModel
    @State private var isShowingAlert: Bool = false
    
    let defect: Defect
    let index: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if let uiImage = UIImage(data: defect.image) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
            }
            
            Text(defect.description)
                .font(.caption)
                .padding()
            
            HStack {
                //TODO: 수정 버튼
                
                Button {
                    isShowingAlert.toggle()
                } label: {
                    HStack {
                        Image(systemName: "trash")
                        
                        Text("삭제")
                    }
                    .font(.subheadline)
                    .foregroundStyle(.red)
                    .padding(12)
                    .frame(maxWidth: .infinity)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke()
                            .fill(.gray)
                    }
                }
            }
            .padding()
        }
        .cornerRadius(10)
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke()
                .fill(Color(red: 229 / 255, green: 227 / 255, blue: 232 / 255))
        }
        .alert(isPresented: $isShowingAlert) {
            Alert(title: Text("알림"), message: Text("결함을 삭제할까요?"), primaryButton: .default(Text("취소")), secondaryButton: .destructive(Text("삭제"), action: {
                withAnimation {
                    viewModel.removeDefect(at: index)
                }
            }))
        }
    }
}

#Preview {
    DefectInputRow(defect: Defect(image: UIImage(named: "SampleImage")!.pngData()!, description: "결함설명"), index: 0)
}
