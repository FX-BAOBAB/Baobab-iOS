//
//  TransactionItemDetail.swift
//  Baobab
//
//  Created by 이정훈 on 9/9/24.
//

import SwiftUI

struct TransactionItemDetail: View {
    @Environment(\.dismiss) private var dismiss
    
    let usedItem: UsedItem
    
    var body: some View {
        ScrollView {
            TabView {
                ForEach(usedItem.item.basicImages, id: \.self) { basicImage in
                    AsyncImage(url: URL(string: basicImage.imageURL)) { image in
                        image
                            .resizable()
                    } placeholder: {
                        Rectangle()
                            .fill(.gray)
                            .overlay {
                                ProgressView()
                            }
                    }
                }
            }
            .tabViewStyle(.page)
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
            
            HStack {
                Text(usedItem.item.name)
                    .font(.title3)
                    .bold()
                
                if let status = usedItem.item.status {
                    StatusLabel(status: status)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                Text(usedItem.item.category.toKorCategory() + ",")
                
                Text("\(usedItem.item.quantity)개")
            }
            .font(.subheadline)
            .foregroundStyle(.gray)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding([.leading, .trailing, .bottom])
            
            Divider()
                .padding([.leading, .trailing])
            
            Section(header: Text("물품 결함").bold().padding([.leading, .top])) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(usedItem.item.defectImages, id: \.self) { image in
                            DefectRow(imageData: image)
                        }
                    }
                    .padding(.leading)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom)
        }
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

#Preview {
    NavigationStack {
        TransactionItemDetail(usedItem: UsedItem.sampleData[0])
    }
}
