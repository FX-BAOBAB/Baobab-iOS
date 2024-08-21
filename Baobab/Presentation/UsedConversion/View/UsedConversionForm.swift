//
//  UsedConversionForm.swift
//  Baobab
//
//  Created by 이정훈 on 8/21/24.
//

import SwiftUI

struct UsedConversionForm: View {
    @StateObject private var viewModel: UsedConversionViewModel
    @Binding var isShowingFullScreenCover: Bool
    
    let item: Item
    
    init(viewModel: UsedConversionViewModel, isShowingFullScreenCover: Binding<Bool>, item: Item) {
        _viewModel = StateObject(wrappedValue: viewModel)
        _isShowingFullScreenCover = isShowingFullScreenCover
        self.item = item
    }
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                HStack(alignment: .top) {
                    AsyncImage(url: URL(string: item.basicImages[0].imageURL)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.width * 0.15)
                            .cornerRadius(10)
                    } placeholder: {
                        Rectangle()
                            .skeleton(with: true,
                                      size: CGSize(width: UIScreen.main.bounds.width * 0.15,
                                                   height: UIScreen.main.bounds.width * 0.15),
                                      shape: .rounded(.radius(10, style: .circular))
                            )
                    }
                    
                    VStack(alignment: .leading) {
                        Text(item.name)
                        
                        Text(item.category.toKorCategory())
                        
                        Text("\(item.quantity)개")
                    }
                    .font(.caption)
                    
                    Spacer()
                }
                .padding()
                
                Divider()
            }
            
            ScrollView {
                BorderedInputBox(inputValue: $viewModel.title,
                                 title: "제목",
                                 placeholder: "제목을 입력해 주세요.",
                                 type: .normal)
                .padding()
                
                BorderedPriceBox(inputValue: $viewModel.price,
                                 title: "가격", placeholder: "")
                .padding()
                
                BorderedDescriptionBox(inputValue: $viewModel.description,
                                       title: "상세설명",
                                       placeholder: "물품의 특징을 자세하게 기술해 주세요.")
                .padding()
            }
            
            VStack(spacing: 0) {
                Divider()
                
                Button {
                    
                } label: {
                    Text("등록하기")
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
        .navigationTitle("중고 판매 등록")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    isShowingFullScreenCover.toggle()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundStyle(.black)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        UsedConversionForm(viewModel: AppDI.shared.makeUsedConversionViewModel(), 
                           isShowingFullScreenCover: .constant(true),
                           item: Item(id: 0,
                                      name: "부끄부끄 마끄부끄",
                                      category: "SMALL_APPLIANCES",
                                      quantity: 1,
                                      basicImages: [ImageData(imageURL: "string", caption: ""),
                                                    ImageData(imageURL: "string", caption: "")],
                                      defectImages: [ImageData(imageURL: "", caption: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
                                                     ImageData(imageURL: "string", caption: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")]
                                     )
        )
    }
}
