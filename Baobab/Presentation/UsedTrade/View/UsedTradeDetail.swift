//
//  UsedTradeDetail.swift
//  Baobab
//
//  Created by 이정훈 on 9/4/24.
//

import SwiftUI

struct UsedTradeDetail: View {
    @Environment(\.dismiss) private var dismiss
    
    let usedItem: UsedItem
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                ScrollView {
                    TabView {
                        ForEach(usedItem.item.basicImages, id: \.self) { image in
                            AsyncImage(url: URL(string: image.imageURL)) { image in
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
                    .frame(width: UIScreen.main.bounds.width,
                           height: UIScreen.main.bounds.width)
                    
                    MainText(usedItem: usedItem)
                    
                    Color.clear
                        .frame(height: 80)
                }
                
                HStack {
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Circle()
                            .frame(width: 60)
                            .foregroundColor(Color(red: 242 / 255, green: 244 / 255, blue: 245 / 255))
                            .overlay {
                                Image(systemName: "message.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30)
                            }
                    }
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
                .padding()
            }
            
            VStack {
                Divider()
                
                HStack {
                    HStack(spacing: 0) {
                        Text("가격: ")
                        
                        Text("\(usedItem.price)")
                            .foregroundStyle(.accent)
                        
                        Text("원")
                    }
                    .bold()
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Text("구매하기")
                            .bold()
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding()
            }
        }
        .edgesIgnoringSafeArea(.top)
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

struct MainText: View {
    let usedItem: UsedItem
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(usedItem.title)
                
                Spacer()
            }
            .font(.title3)
            .bold()
            .padding([.leading, .top])
            
            Text(Date.toSimpleFormat(from: usedItem.postedAt, format: .full))
                .foregroundStyle(.gray)
                .font(.subheadline)
                .padding(.leading)
            
            Text(usedItem.description)
                .padding()
                .font(.subheadline)
            
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
        }
    }
}

#Preview {
    NavigationStack {
        UsedTradeDetail(usedItem: UsedItem.sampleData[0])
    }
}
