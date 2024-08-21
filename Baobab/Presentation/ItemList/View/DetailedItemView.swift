//
//  DetailedItemView.swift
//  Baobab
//
//  Created by 이정훈 on 7/26/24.
//

import SwiftUI

struct DetailedItemView: View {
    @State private var isShowingFullScreenCover: Bool = false
    
    let item: Item
    let status: ItemStatus
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                ScrollView {
                    TabView {
                        ForEach(item.basicImages, id: \.self) { basicImage in
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
                        Text(item.name)
                            .font(.title3)
                            .bold()
                        
                        StatusLabel(status: status)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack {
                        Text(item.category.toKorCategory() + ",")
                        
                        Text("\(item.quantity)개")
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
                                ForEach(item.defectImages, id: \.self) { image in
                                    DefectRow(imageData: image)
                                }
                            }
                            .padding(.leading)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom)
                }
            }
            .navigationTitle("상세보기")
            .navigationBarTitleDisplayMode(.inline)
            
            if status == .stored {
                VStack(spacing: 0) {
                    Divider()
                    
                    Button {
                        isShowingFullScreenCover.toggle()
                    } label: {
                        Text("중고전환 신청")
                            .bold()
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding(15)
                            .background(.accent)
                    }
                    .cornerRadius(10)
                    .padding()
                }
                .background(.white)
            }
        }
        .fullScreenCover(isPresented: $isShowingFullScreenCover) {
            NavigationStack {
                UsedConversionForm(viewModel: AppDI.shared.makeUsedConversionViewModel(),
                                   isShowingFullScreenCover: $isShowingFullScreenCover,
                                   item: item)
            }
        }
    }
}

#Preview {
    NavigationStack {
        DetailedItemView(item: Item(id: 0,
                                    name: "부끄부끄 마끄부끄",
                                    category: "SMALL_APPLIANCES",
                                    quantity: 1,
                                    basicImages: [ImageData(imageURL: "string", caption: ""),
                                                  ImageData(imageURL: "string", caption: "")],
                                    defectImages: [ImageData(imageURL: "", caption: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
                                                   ImageData(imageURL: "string", caption: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")]),
                         status: .receiving)
    }
}
