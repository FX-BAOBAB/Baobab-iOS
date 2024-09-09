//
//  TransactionItemDetail.swift
//  Baobab
//
//  Created by 이정훈 on 9/9/24.
//

import SwiftUI

struct TransactionItemDetail: View {
    @Environment(\.dismiss) private var dismiss
    @State private var isShowingActionSheet: Bool = false
    
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
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    isShowingActionSheet.toggle()
                } label: {
                    Image(systemName: "ellipsis")
                        .rotationEffect(.degrees(-90))
                }
            }
        }
        .actionSheet(isPresented: $isShowingActionSheet) {
            ActionSheet(title: Text("더보기"), buttons: [
                .default(Text("전문보기"), action: {
                    // 전문으로 이동
                }),
                .cancel()
            ])
        }
    }
}

#Preview {
    NavigationStack {
        TransactionItemDetail(usedItem: UsedItem.sampleData[0])
    }
}
